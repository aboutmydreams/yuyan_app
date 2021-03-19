import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/config/viewstate/view_state_widget.dart';

/// 获取网络数据，携带状态管理。
/// 子类需要实现[fetch]接口，用于获取数据
/// 一个子类只能获取一个特定的数据，如果数据是List、Map类型，请自行检测内部数据是否为空
abstract class FetchValueController<T> extends GetxController
    with ControllerStateMixin {
  FetchValueController({
    /// 用于初始化默认数据，不过大部分情况下并没有所谓的默认数据，就让空着吧
    T initValue,

    /// 默认状态为[ViewState.loading]，以防状态好了数据还是[null]的情况。
    ViewState initialState = ViewState.loading,

    /// 创建的时候调用[initFetch]进行数据的获取
    bool initialFetch = true,
  }) : _value = initValue {
    initState(initialState);
    if (initialFetch) {
      initFetch();
    }
  }

  T _value;

  T get value => _value;

  /// 更新保存的[value]，并从构建监听的子组件
  set value(T newValue) {
    _value = newValue;
    update();
  }

  /// 数据是否可用，用于判断刷新时候是否需要切换[ViewState.loading]状态
  bool get valueAvailable => _value != null;

  /// 检查获取的数据是否是空数据，用于切换[ViewState.empty]状态
  /// 子类可以重写，用于处理非[List]或者[List]永远非空的情况
  bool isEmpty(T data) => GetUtils.isNullOrBlank(data);

  @protected
  initFetch() => onRefresh(force: true);

  /// 数据刷新，调用[fetch]进行数据更新
  /// force = true, 说明要强制更新数据，哪怕[fetch]返回的是[null]数据
  onRefresh({bool force = false}) async {
    try {
      if (!valueAvailable) {
        /// 数据不可用时，变成加载状态
        setLoading();
      }
      var data = await fetch();
      if (isEmpty(data)) {
        /// 如果之前的数据不可用，置为空状态
        /// 否则，说明之前已经存在数据，这次加载数据失败!
        /// 但是并不触发空状态，为了更好的用户体验
        /// 还有一种情况就是，[force=true] 说明要强制更新数据
        if (force || !valueAvailable) setEmpty();
      } else {
        /// 数据正常加载，更新原先数据，通知 listeners
        _value = data;
        setIdle();
      }
    } catch (e) {
      /// 这里说明数据加载出错
      /// 为了更好的用户体验，对于之前已有数据情况下，默认不会触发错误状态
      /// 而是触发 [onFetchError] 函数
      if (force || !valueAvailable) {
        setError(e);
      } else {
        onFetchError(e);
      }
    }
  }

  /// 获取数据接口
  Future<T> fetch();

  @override
  onInit() {
    super.onInit();
    debugPrint('${this.runtimeType} => onInit');
  }

  @override
  onReady() {
    debugPrint('${this.runtimeType} => onReady');
  }

  @override
  onClose() {
    debugPrint('${this.runtimeType} => onClose');
  }
}

/// 获取列表数据，继承于[FetchValueController]
/// 携带[RefreshController]，用于构建下拉刷新，加载更多
/// 添加[加载更多]接口
abstract class FetchListValueController<T>
    extends FetchValueController<List<T>> {
  final RefreshController refreshController;

  FetchListValueController({
    List<T> initValue,
    ViewState initialState = ViewState.loading,
    bool initialFetch = true,
  })  : refreshController = RefreshController(),
        super(
          initValue: initValue,
          initialFetch: initialFetch,
          initialState: initialState,
        );

  @override
  bool get valueAvailable => !GetUtils.isNullOrBlank(_value);

  /// 刷新数据，快捷方法，用于[SmartRefresh]组件
  refreshCallback() => onRefresh();

  /// 加载更多数据，快捷方法，用于[SmartRefresh]组件
  loadMoreCallback() => onRefreshMore();

  /// 加入了处理[RefreshController]的逻辑，其它流程和父类一样
  @override
  onRefresh({bool force = false}) async {
    try {
      if (!valueAvailable) {
        setLoading();
      }
      refreshController.resetNoData();
      var data = await fetch();
      if (isEmpty(data)) {
        if (force || !valueAvailable) {
          setEmpty();
        }
      } else {
        _value = data;
        setIdle();
      }
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
      if (force || !valueAvailable) {
        setError(e);
      } else {
        onFetchError(e);
      }
    }
  }

  /// 引入加载更多的流程，方便分页加载
  onRefreshMore() async {
    try {
      var data = await fetchMore();
      if (isEmpty(data)) {
        refreshController.loadNoData();
      } else {
        _value.addAll(data);
        refreshController.loadComplete();
        setIdle();
      }
    } catch (e) {
      refreshController.loadFailed();
      onFetchError(e);
    }
  }

  /// 如果需要[onRefreshMore]的功能，请重新此方法
  Future<List<T>> fetchMore() => null;

  /// convenient methods
  void add(T newItem) {
    _value?.add(newItem);
    update();
  }

  void remove(T oldItem) {
    _value?.remove(oldItem);
    update();
  }
}

abstract class FetchSavableController<T extends BaseSavableJson>
    extends FetchValueController<T> {
  final bool _initialRefresh;
  final RefreshController refreshController;

  bool get valueAvailable => !GetUtils.isNullOrBlank(_value?.data);

  FetchSavableController({
    bool initialRefresh = false,
    ViewState state = ViewState.idle,
    @required T initData,
  })  : refreshController = RefreshController(),
        _initialRefresh = initialRefresh,
        assert(initData != null, 'initData must not be null'),
        super(
          initValue: initData,
          initialFetch: false,
          initialState: state,
        );

  @override
  onInit() {
    super.onInit();
    if (_initialRefresh) {
      onRefreshCallback();
    }
  }

  onRefreshCallback() async {
    try {
      if (!valueAvailable) {
        setLoading();
      }
      refreshController.resetNoData();
      var data = await fetchData();
      value.data = data;
      if (GetUtils.isNullOrBlank(data)) {
        setEmpty();
      } else {
        setIdle();
      }
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
      if (valueAvailable) {
        onFetchError(e);
      } else {
        setError(e);
      }
    }
  }

  onLoadMoreCallback() async {
    try {
      if (state == ViewState.empty) {
        refreshController.loadNoData();
        return;
      }
      var data = await fetchMore();
      if (GetUtils.isNullOrBlank(data)) {
        refreshController.loadNoData();
      } else {
        if (value.data is List) {
          (value.data as List).addAll(data);
          value.updateData();
        }
        setIdle();
        refreshController.loadComplete();
      }
    } catch (e) {
      refreshController.loadFailed();
      if (valueAvailable) {
        onFetchError(e);
      } else {
        setError(e);
      }
    }
  }

  //这个接口在此类无用
  Future<T> fetch() => null;

  /// 加载更多数据，适用于接口分页的情况
  /// 额外接口的原因是，适用无需分页的接口
  /// 这里需要自己做好[分页]的管理
  Future fetchMore() => null;

  Future fetchData();

  Widget builder(
    NotifierBuilder<T> builder, {
    Widget onLoading,
    Widget onEmpty,
    Widget Function(ViewError error) onError,
  }) {
    switch (state) {
      case ViewState.refreshing:
      case ViewState.idle:
        return builder(value);
      case ViewState.empty:
        return onEmpty ?? const ViewEmptyWidget();
      case ViewState.loading:
        return onLoading ?? const ViewLoadingWidget();
      case ViewState.error:
        if (onError != null) {
          return onError(error);
        }
        return ViewErrorWidget(error: error);
    }
    return SizedBox.shrink();
  }
}
