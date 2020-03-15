import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/begin_init/login_page/login_page.dart';

class SettingPage extends StatefulWidget {
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          ChangeColorTile(),
          ListTile(
            title: Text(
              '退出登录',
              textAlign: TextAlign.left,
            ),
            leading: Icon(
              Icons.power_settings_new,
            ),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();

              CookieManager cookieManager = CookieManager();
              bool hadCookies = await cookieManager.clearCookies();
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(
                    builder: (BuildContext context) => new LoginPage(),
                  ),
                  (Route route) => route == null);
            },
          ),
        ],
      ),
    );
  }
}

class ChangeColorTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '神奇按键',
        textAlign: TextAlign.left,
      ),
      leading: Icon(
        Icons.insert_emoticon,
        // color: Colors.black12,
        // size: 22.0,
      ),
      onTap: topModel.changeColor,
    );
  }
}
