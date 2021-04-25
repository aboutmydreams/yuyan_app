import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/controller/home/login_controller.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FlutterWebviewPlugin webviewPlugin;

  @override
  void initState() {
    super.initState();
    webviewPlugin = FlutterWebviewPlugin();
    Get.put(LoginController(webviewPlugin));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (c) => WebviewScaffold(
        userAgent: Config.userAgent,
        url: c.authUrl,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "登录语雀",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    webviewPlugin.dispose();
    super.dispose();
  }
}
