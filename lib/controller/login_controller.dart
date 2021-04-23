import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/net/token.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/config/service/api2_repository.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';

class LoginController extends FetchValueController<TokenJsonSeri> {
  final FlutterWebviewPlugin controller;
  final TokenProvider provider = App.tokenProvider;

  LoginController(this.controller)
      : super(initialFetch: false, initialState: ViewState.idle) {
    controller.onUrlChanged.listen(onUrlChanged);
    controller.onStateChanged.listen(onStateChanged);
  }

  String get authUrl {
    final String _baseUrl = "https://www.yuque.com/oauth2/authorize?";
    var param = {
      "client_id": Config.clientId,
      "response_type": "code",
      "scope": "group,repo,doc,topic,artboard",
      "redirect_uri": "yuyan://login",
    };
    final query = param.keys.map((key) => '$key=${param[key]}').join('&');
    return _baseUrl + query;
  }

  String _code = '';

  //监听登陆事件
  onUrlChanged(String url) {
    debugPrint('url change: $url');
    if (url.startsWith("yuyan://")) {
      controller.hide();
      //获取Code
      var uri = Uri.parse(url);
      _code = uri.queryParameters['code'];
      onRefresh(force: true);
    }
  }

  // 隐藏语雀第三方登录， iOS 审核需要
  onStateChanged(state) {
    Timer(Duration(milliseconds: 100), (){
      final js = 'document.querySelector(".third-login").style.display="none";';
      controller.evalJavascript(js);
    });
    if (state.type == WebViewState.finishLoad) {
      final js = 'document.querySelector(".third-login").style.display="none";';
      controller.evalJavascript(js);
    }
  }

  @override
  onError() {
    Fluttertoast.showToast(
      msg: '${error.title}',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
    );
    controller.reloadUrl(authUrl);
    controller.show();
  }

  @override
  Future<TokenJsonSeri> fetch() async {
    var token = await Api2Repository.getTokenByCode(code: _code);
    

    String cookies = await controller.getAllCookies("https://www.yuque.com/dashboard");
    debugPrint("token.toString()===========");
    debugPrint(cookies);
    debugPrint("token.toString()===========");
    if (cookies == null) throw '没有Cookie';
    // 判断是否有认证 Cookie
    var valid =
        cookies.contains("_yuque_session") && cookies.contains("ctoken");
    if (!valid) throw '不合法的会话';
    //保存登陆凭据
    token.loadCookies(cookies);
    provider.updateData(token);
    Future.delayed(Duration(milliseconds: 300), () {
      App.analytics.logLogin(loginMethod: 'webview');
      Get.offAllNamed(RouteName.home);
    });
    return token;
  }
}
