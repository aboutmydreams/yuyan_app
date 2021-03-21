import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/net/api.dart';

import 'view_state_widget.dart';

enum ViewState {
  idle, //加载完毕，闲置状态
  empty, //加载完毕，无数据
  loading, //数据加载中，有可能是第一次加载，从无到有
  refreshing, //数据刷新中，说明之前已经加载过数据，进行数据的更新
  error, //数据加载失败，出错了，使用 [ViewStateError] 来表示错误信息
}

enum ViewErrorType {
  //用于提示用户操作不正当或者其它，这类错误只需要给个提示即可
  info, //操作提示错误

  //显示特定提示，或者引导用户上报
  api, //API错误，例如422,API参数错误等, 404,API不存在等

  //显示特定提示，或者引导用户上报
  dart, //一般是dart本身抛出的异常，例如null异常，或者类型不匹配产生的错误

  //给出重试、刷新按钮
  network, //Dio请求错误，一般是网络问题，例如timeout等

  //这类错误需要引导进行重新登陆
  unauthorized, //401 API认证错误

  //未知错误
  unknown, //其它任何没有考虑到的情况！
}

class ViewError {
  final String title;
  final String content;
  final dynamic error;
  final ViewErrorType type;

  ViewError({
    this.title = '未知错误',
    this.content = '未知错误描述信息',
    this.error = 'error',
    this.type = ViewErrorType.unknown,
  });

  @override
  String toString() {
    var errDebug = '''{
    "title": $title,
    "content":$content,
    "error": ${Error.safeToString(error)},
    "type": $type
}''';
    return errDebug;
  }
}

mixin ControllerStateMixin on GetxController {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  ViewError error;

  set state(ViewState newState) {
    _state = newState;
    update();
  }

  //controller状态快捷获取
  bool get isEmptyState => state == ViewState.empty;

  bool get isErrorState => state == ViewState.error;

  bool get isLoadingState => state == ViewState.loading;

  bool get isRefreshState => state == ViewState.refreshing;

  bool get isIdleState => state == ViewState.idle;

  //状态的快捷设置方法
  setIdle() => state = ViewState.idle;

  setEmpty() => state = ViewState.empty;

  setLoading() => state = ViewState.loading;

  setRefreshing() => state = ViewState.refreshing;

  setError(e, [stack]) {
    assert(
      e != null,
      'setError called with null parameter,'
      ' do you really mean an error has occurred?',
    );

    //TODO(@dreamer2q): 测试错误处理

    error = _handlerError(e);

    state = ViewState.error;
    onError?.call();

    //used for debug
    _errorPrint(e, stack);
  }

  ViewError _handlerApiError(ApiError err) {
    if (err.response.status == 401) {
      return ViewError(
        title: '未认证',
        content: err.response.errorDescription(),
        error: err,
        type: ViewErrorType.unauthorized,
      );
    }
    return ViewError(
      title: 'API错误',
      content: err.response.errorDescription(),
      error: err,
      type: ViewErrorType.api,
    );
  }

  ViewError _handlerError(e) {
    switch (e.runtimeType) {
      case String: //人为throw的错误，主要用于错误提示
        return ViewError(
          title: e,
          type: ViewErrorType.info,
        );
      case ApiError: //请求正常，返回的是API错误
        return _handlerApiError(e);
      case DioError: //请求可能识别了，例如网络超时等
        var err = (e as DioError).error;
        //这里Dio会将错误强制包装成DioError类型
        //因此只能通过这个来判断是否ApiError
        //TODO(@dreamer2q): 测试错误处理，例如超时等。
        if ((e as DioError).type == DioErrorType.other)
          return _handlerError(err);
        // switch (err.runtimeType) {
        //   case ApiError:
        //     return _handlerApiError(err);
        //   case SocketException:
        //     return ViewError(
        //       title: 'Socket错误',
        //       content: err.message,
        //       error: err,
        //       type: ViewErrorType.network,
        //     );
        //   default:
        // }
        return ViewError(
          title: '网络错误',
          content: Error.safeToString(err.error),
          error: err,
          type: ViewErrorType.network,
        );
      case SocketException: //网络错误，更底层的错误
        var err = e as SocketException;
        return ViewError(
          title: 'Socket错误',
          content: err.message,
          error: err,
          type: ViewErrorType.network,
        );
      case NoSuchMethodError: //调用null对象
        var err = e as NoSuchMethodError;
        return ViewError(
          title: '空对象错误(NoSuchMethod)',
          content: '开发者没有很好的处理特殊情况，\n并抛给你一个NULL错误',
          error: err,
          type: ViewErrorType.dart,
        );
      case RangeError: //数组越界
      case IndexError: //同上
        var err = e as ArgumentError;
        return ViewError(
          title: '数组越界',
          content: 'SB开发者，连这个错误都处理不好\n'
              '${err.name} => ${err.message}',
          error: e,
          type: ViewErrorType.dart,
        );
      case FormatException: //String字符出现非法编码
        var err = e as FormatException;
        return ViewError(
          title: 'App内部错误',
          content: Error.safeToString(err.message),
          error: e,
          type: ViewErrorType.dart,
        );
      case TypeError: //类型转换错误，通常出现在json序列化的过程中
        return ViewError(
          title: '类型错误',
          content: Error.safeToString(e),
          error: e,
          type: ViewErrorType.dart,
        );
      default: //其它未处理的错误
        return ViewError(
          title: '未知错误',
          content: Error.safeToString(e),
          error: e,
          type: ViewErrorType.unknown,
        );
    }
  }

  /// 错误发生时调用，状态变成 [ViewState.error]
  onError() {}

  /// 数据加载失败时触发，一般情况就是弹出 [toast] 进行提示
  /// 注意，这里的状态并没有变成 [ViewState.error]
  onFetchError(error) {}

  @protected
  initState(ViewState initState) {
    _state = initState;
  }

  /// [stateBuilder] is a convenient way to handle different states
  /// but, [stateBuilder] is not reactive,
  /// so you need to wrap it in [GetBuilder] to make it reactive
  /// once [onIdle] is called, it means [value] is available
  /// and you can use it safely
  /// the [onLoading],[onEmpty], [onError] has its default handler or widget,
  /// so you can focus you main task
  Widget stateBuilder<T>({
    WidgetCallback onIdle,
    Widget onLoading,
    Widget onEmpty,
    Widget Function(ViewError error) onError,
  }) {
    switch (state) {
      case ViewState.refreshing:
      case ViewState.idle:
        return onIdle();
      case ViewState.empty:
        return onEmpty ?? const ViewEmptyWidget();
      case ViewState.loading:
        return onLoading ?? const ViewLoadingWidget();
      case ViewState.error:
        if (onError != null) {
          return onError(error);
        }
        return ViewErrorWidget(error: error);
      default:
      //当状态为空的情况
    }
    return SizedBox.shrink();
  }

  /// [safeHandler] is a method wrapper which helps catch errors,
  /// useful for handling error throwable functions
  safeHandler(Function callback, {bool initLoading = false}) async {
    try {
      if (initLoading) {
        setLoading();
      }
      await callback?.call();
      setIdle();
    } catch (e) {
      setError(e);
    }
  }

  /// [_errorPrint] is a private handler for debug messages
  _errorPrint(error, [stack]) async {
    var debug = '👇👇👇👇👇👇👇 ERROR 👇👇👇👇👇👇👇\n$error\n';
    if (stack != null) {
      debug += '---===💔💔💔💔💔 STACK 💔💔💔💔💔===---\n$stack\n';
    }
    debug += '👆👆👆👆👆👆👆 OVER 👆👆👆👆👆👆👆👆\n';
    debugPrint(debug);
  }
}
