import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';

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

  setError(error) {
    //TODO setError
    Get.snackbar(
      'error',
      error.toString(),
      snackPosition: SnackPosition.BOTTOM,
    );

    debugPrint('''!!!!!!!!!!!!!! ERROR !!!!!!!!!!!!!!!!!
$error
!!!!!!!!!💔💔!💔💔!💔💔!💔💔!💔💔!!!!!!!!!!''');
  }

  @protected
  initState(ViewState initState) {
    _state = initState;
  }

  Widget stageBuilder({
    Widget onIdle,
    Widget onLoading,
    Widget onEmpty,
    Widget Function(ViewStatusError error) onError,
  }) {
    switch (state) {
      case ViewState.refreshing:
      case ViewState.idle:
        return onIdle;
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
