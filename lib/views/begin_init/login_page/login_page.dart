import 'dart:async';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/models/net/requests_api/user/user.dart';
import 'package:yuyan_app/models/oauth2/oauth2.dart';
import 'package:yuyan_app/models/tools/analytics.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

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
    justHide();
    super.initState();
  }

  // 隐藏微信登录
  justHide() {
    Timer(const Duration(milliseconds: 0), () {
      Timer(Duration(milliseconds: 400), () {
        hidethirdLogin();
        justHide();
      });
    });
  }

  hidethirdLogin() {
    final future = flutterWebviewPlugin.evalJavascript(
        'document.querySelector(".third-login").style.display="none";');
    // future.then((String result) {
    //   print(result);
    // });
  }

  /// 轮询 asses token api
  /// 设置超时时间 `timeout` = 3 min
  /// https://api.dartlang.org/stable/2.2.0/dart-async/Timer/Timer.periodic.html
  askTokenApi() {
    int askTimes = 1;
    int timeoutTimes = 60;
    // 轮询函数，如果没有正确结果再次调用自己
    askYuque(int a) {
      // 定时器
      Timer(
        const Duration(milliseconds: 3000),
        () async {
          bool isLogin = await oauth2.saveAccessToken();
          if (isLogin) {
            // myOldToast("登录成功");
            Timer(const Duration(milliseconds: 3000), () {
              getAllCookies(flutterWebviewPlugin).then((res) {
                topModel.update();
              });
            });

            // 3s 后跳转
            Timer(
              const Duration(milliseconds: 3000),
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

          if ((askTimes < timeoutTimes) && (!logined)) {
            askYuque(askTimes);
          } else if (askTimes >= timeoutTimes) {
            myToast(context, "验证超时，请稍后重试");
          } else {}
        },
      );
    }

    askYuque(askTimes);

    // Timer.periodic(Duration(milliseconds: 3000), askYuque(askTimes));
  }

  // 获取cookie并保存
  Future<Null> getAllCookies(FlutterWebviewPlugin flutterWebviewPlugin) async {
    String cookieResult = await flutterWebviewPlugin
        .getAllCookies("https://www.yuque.com/dashboard");
    Map<String, dynamic> cookieData = {};

    print("getAllCookies=========");
    if (cookieResult != null) {
      List<String> cookiesList = cookieResult.split(";");
      cookiesList.removeLast();

      for (var cookie in cookiesList) {
        cookieData[cookie.substring(0, cookie.indexOf("="))] = cookie.substring(
          cookie.indexOf("=") + 1,
        );
      }

      // 判断是否有认证 Cookie
      bool haveSession(String cookie) =>
          cookie.contains("_yuque_session") && cookie.contains("ctoken");

      if (haveSession(cookieResult)) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("_yuque_session", cookieData["_yuque_session"]);
        await prefs.setString("ctoken", cookieData["yuque_ctoken"]);
        await prefs.setString("all_cookies", cookieResult);

        // 关注语燕项目文档和语雀的天空推送
        await DioUser.watchBook(bookId: 624070, actionOption: "notify");
        await DioUser.watchBook(bookId: 103555);
        // 👀👀开发者
        // await DioUser.followUser(userId: 164272);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(oauthUrl);
    analytics.logEvent(name: 'login');
    return WebviewScaffold(
      url: oauthUrl,
      appBar: AppBar(
        title: Text("登录语雀", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
    );
  }
}
