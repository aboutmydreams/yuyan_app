import 'dart:async';

import 'package:yuyan_app/models/browser_web/browser_appbar.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/models/oauth2/oauth2.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String oauthUrl;
  Oauth oauth2 = Oauth();
  @override
  void initState() {
    String url = oauth2.getOauthUrl();
    oauthUrl = url;
    super.initState();
  }

  // 获取语雀 oauth2 url
  // 轮询 asses token api
  getOauthUrl() {
    Timer timer = new Timer(
      const Duration(milliseconds: 3000),
      () {
        try {
          Navigator.pushNamedAndRemoveUntil(
              context, "/", (route) => route == null);
        } catch (e) {}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BrowserWithBar(
      url: oauthUrl,
      appbar: AppBar(
        title: Text("登录语雀"),
      ),
    );
  }
}
