import 'dart:async';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/models/oauth2/oauth2.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Oauth oauth2 = Oauth();
  String oauthUrl;
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  bool logined = false;

  @override
  void initState() {
    // 获取语雀 oauth2 url
    String url = oauth2.getOauthUrl().toString();
    oauthUrl = url;
    askTokenApi();
    super.initState();
  }

  /// 轮询 asses token api
  /// 设置超时时间 `timeout` = 3 min
  /// https://api.dartlang.org/stable/2.2.0/dart-async/Timer/Timer.periodic.html
  askTokenApi() {
    int askTimes = 1;
    int timeoutTimes = 60;
    askYuque(int a) {
      Timer(
        const Duration(milliseconds: 3000),
        () async {
          bool isLogin = await oauth2.saveAccessToken();
          if (isLogin) {
            myToast("登录成功");
            getAllCookies(flutterWebviewPlugin).then((res) {
              topModel.update();
            });
            Timer(
              const Duration(microseconds: 3),
              () {
                setState(
                  () {
                    logined = true;
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => route == null);
                  },
                );
              },
            );
          }
          print(isLogin);
          print(askTimes);
          askTimes += 1;

          if ((askTimes < timeoutTimes) & (!logined)) {
            askYuque(askTimes);
          } else if (askTimes >= timeoutTimes) {
            myToast("验证超时，请稍后重试");
          } else {}
        },
      );
    }

    askYuque(askTimes);

    // Timer.periodic(Duration(milliseconds: 3000), askYuque(askTimes));
  }

  // 获取cookie并保存
  Future<Null> getAllCookies(FlutterWebviewPlugin flutterWebviewPlugin) async {
    final String result = await flutterWebviewPlugin
        .getAllCookies("https://www.yuque.com/dashboard");
    Map<String, dynamic> cookieData = {};
    List<String> cookiesList = result.split(";");
    cookiesList.removeLast();
    for (var cookie in cookiesList) {
      cookieData[cookie.substring(0, cookie.indexOf("="))] = cookie.substring(
        cookie.indexOf("=") + 1,
      );
    }
    bool haveSession(String cookie) =>
        cookie.contains("_yuque_session") && cookie.contains("ctoken");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (haveSession(result)) {
      // print(result);
      prefs.setString("_yuque_session", cookieData["_yuque_session"]);
      prefs.setString("ctoken", cookieData["ctoken"]);
    }

    prefs.setString("all_cookies", result);
  }

  @override
  Widget build(BuildContext context) {
    print(oauthUrl);
    return WebviewScaffold(
      url: oauthUrl,
      appBar: new AppBar(
        title: new Text("登录语雀", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
    );
  }
}
