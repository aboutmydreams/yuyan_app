import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuyan_app/config/storage_manager.dart';

enum ViewState {
  idle, //加载完毕，闲置状态
  empty, //加载完毕，无数据
  loading, //数据加载中，有可能是第一次加载，从无到有
  refreshing, //数据刷新中，说明之前已经加载过数据，进行数据的更新
  error, //数据加载失败，出错了，使用 [ViewStateError] 来表示错误信息
}

enum ViewStateError {
  api,
}

class ViewStatusError {
  final String title;
  final String content;
  final dynamic error;

  ViewStatusError({
    this.title,
    this.content,
    this.error,
  });
}

mixin ControllerStateMixin on GetxController {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  ViewStatusError error;

  set state(ViewState newState) {
    _state = newState;
    update();
  }

  setIdle() => state = ViewState.idle;

  setEmpty() => state = ViewState.empty;

  setLoading() => state = ViewState.loading;

  setRefreshing() => state = ViewState.refreshing;

  setError(ViewStatusError error) {
    //TODO setError
  }

  @protected
  initState(ViewState initState) {
    _state = initState;
  }
}

abstract class FetchRefreshController<T extends BaseSavableJson>
    extends GetxController with ControllerStateMixin {
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
    T initData,
  }) : _value = initData {
    initState(state);
    refreshController = RefreshController(initialRefresh: initialRefresh);
  }

  onRefresh() async {
    try {
      if (value.isBlank) {
        setLoading();
      } else {
        setRefreshing();
      }
      var data = await refreshData();
      if (data != null && !GetUtils.isBlank(data)) {
        value.data = data;
        setIdle();
      } else {
        if (state == ViewState.loading) {
          setEmpty();
        }
      }
      refreshController.refreshCompleted();
      refreshController.resetNoData();
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
        (value.data as List).addAll(data);
        setIdle();
        refreshController.loadComplete();
      } else {
        if (state == ViewState.loading) {
          setEmpty();
        }
        refreshController.loadNoData();
      }
    } catch (e) {
      setError(e);
      refreshController.loadFailed();
    }
  }

  Future fetchMoreData();

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
        return onEmpty ??
            Center(
              child: Text('empty'),
            );
      case ViewState.loading:
        return onLoading ??
            Center(
              child: RefreshProgressIndicator(),
            );
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
