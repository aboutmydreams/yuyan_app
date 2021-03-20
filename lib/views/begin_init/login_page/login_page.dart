import 'dart:async';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/models/oauth2/oauth2.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/util/util.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FlutterWebviewPlugin webviewPlugin = FlutterWebviewPlugin();
  OAuth2 oauth2 = OAuth2();
  String oauthUrl;

  @override
  void dispose() {
    super.dispose();

    webviewPlugin.dispose();
  }

  @override
  void initState() {
    super.initState();
    oauthUrl = oauth2.getOauthWebUrl();

    webviewPlugin.onUrlChanged.listen((url) {
      debugPrint('url change: $url');
      if (url.startsWith("yuyan://")) {
        webviewPlugin.hide();
        //获取Code
        var uri = Uri.parse(url);
        var code = uri.queryParameters['code'];
        processLogin(code).catchError((err) {
          Util.toast(err.toString());
          webviewPlugin.reloadUrl(oauthUrl);
          webviewPlugin.show();
        });
      }
    });

    webviewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        blockThirdLogin();
      }
    });
  }

  //隐藏语雀第三方登录，IOS审核需要
  blockThirdLogin() {
    webviewPlugin
        .evalJavascript(
            'document.querySelector(".third-login").style.display="none";')
        .catchError((_) {});
  }

  //登录处理流程
  Future<Null> processLogin(String code) async {
    String cookieResult =
        await webviewPlugin.getAllCookies("https://www.yuque.com/dashboard");

    print("getAllCookies=========");
    if (cookieResult == null) throw 'no cookie found';

    List<String> cookiesList = cookieResult.split(";")..removeLast();

    Map<String, String> cookieData = {};
    for (var cookie in cookiesList) {
      var arr = cookie.split("=");
      var key = arr[0], val = arr[1];
      cookieData[key] = val;
    }

    // 判断是否有认证 Cookie
    var hasValidSession = cookieResult.contains("_yuque_session") &&
        cookieResult.contains("ctoken");

    if (!hasValidSession) throw 'invalid session';

    if (!await oauth2.challengeAccessToken(code))
      throw 'challenge access token failed';

    App.tokenProvider.data.loadCookies(cookieResult);
    App.tokenProvider.updateData(App.tokenProvider.data);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("_yuque_session", cookieData["_yuque_session"]);
    await prefs.setString("ctoken", cookieData["yuque_ctoken"]);
    await prefs.setString("all_cookies", cookieResult);

    // 关注语燕项目文档和语雀的天空推送
    // await DioUser.watchBook(bookId: 624070, actionOption: "notify");
    // await DioUser.watchBook(bookId: 103555);
    // 👀👀开发者
    // await DioUser.followUser(userId: 164272);

    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => route == null);
    Get.offAllNamed(RouteName.home);
  }

  @override
  Widget build(BuildContext context) {
    print(oauthUrl);
    return WebviewScaffold(
      url: oauthUrl,
      appBar: AppBar(
        title: Text(
          "登录语雀",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
