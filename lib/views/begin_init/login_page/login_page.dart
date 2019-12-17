import 'dart:async';

import 'package:yuyan_app/models/browser_web/browser_appbar.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/models/oauth2/oauth2.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/views/home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Oauth oauth2 = Oauth();
  String oauthUrl;
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
            setState(
              () {
                logined = true;
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => route == null);
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

  @override
  Widget build(BuildContext context) {
    print(oauthUrl);
    return BrowserWithBar(
      url: oauthUrl,
      appbar: AppBar(
        title: Text("登录语雀", style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
    );
  }
}
