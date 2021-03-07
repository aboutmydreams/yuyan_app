import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';

abstract class FetchRefreshController<T extends BaseSavableJson>
    extends GetxController with ControllerStateMixin {
  final _initialRefresh;
  RefreshController refreshController;

  T _value;

  T get value => _value;

  bool get isNull => _value.data == null;

  set value(T newData) {
    _value = newData;
    update();
  }

  FetchRefreshController({
    bool initialRefresh = false,
    ViewState state = ViewState.idle,
    @required T initData,
  })  : _value = initData,
        _initialRefresh = initialRefresh {
    initState(state);
    refreshController = RefreshController();
  }

  @override
  onInit() {
    super.onInit();

    if (_initialRefresh) {
      onRefresh();
    }
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

  onRefresh() async {
    try {
      if (this.isNull) {
        setLoading();
      } else {
        setRefreshing();
      }
      var data = await refreshData();
      value.data = data;
      if (data != null && !GetUtils.isBlank(data)) {
        setIdle();
      } else {
        setEmpty();
      }
      refreshController.refreshCompleted();
      refreshController.resetNoData();
      refreshController.loadComplete();
    } catch (e) {
      setError(e);
      refreshController.refreshFailed();
    }
  }

  onLoadMore() async {
    try {
      if (value.isBlank) {
        setLoading();
      }
      var data = await fetchMoreData();
      if (data != null && !GetUtils.isBlank(data)) {
        if (value.data is List) {
          (value.data as List).addAll(data);
        }
        setIdle();
        refreshController.loadComplete();
      } else {
        if (state == ViewState.loading) {
          setEmpty();
        }
        refreshController.loadNoData();
      }
    } catch (e) {
      // setError(e);
      refreshController.loadFailed();
      debugPrint(e.toString());
    }
  }

  Future fetchMoreData() => null;

  Future refreshData();

  Widget builder(
    NotifierBuilder<T> builder, {
    Widget onLoading,
    Widget onEmpty,
    Widget Function(ViewStatusError error) onError,
  }) {
    switch (state) {
      case ViewState.refreshing:
      case ViewState.idle:
        return builder(value);
      case ViewState.empty:
        return onEmpty ?? ViewEmptyWidget();
      case ViewState.loading:
        return onLoading ?? ViewLoadingWidget();
      case ViewState.error:
        if (onError != null) {
          return onError(error);
        }
        return Center(
          child: Text('error: $error}'),
        );
    }
    return SizedBox.shrink();
  }
}
