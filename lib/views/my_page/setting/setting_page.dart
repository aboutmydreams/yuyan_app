import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yuyan_app/models/tools/analytics.dart';
import 'package:yuyan_app/models/widgets_small/show_dialog/show_confirm.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/begin_init/login_page/login_page.dart';
import 'package:yuyan_app/views/my_page/setting/view/one_tile.dart';

class SettingPage extends StatefulWidget {
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  checkVersion() {
    if ((Platform.isIOS)) {}
    topModel.versionManage.checkVersion(context);
  }

  @override
  Widget build(BuildContext context) {
    print(topModel.versionManage.isLastest);
    analytics.logEvent(name: 'setting');
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          // ChangeColorTile(),
          SettingTile(
            title: '神奇按键',
            icon: Icons.insert_emoticon,
            onTap: topModel.changeColor,
          ),
          SettingTile(
            title: '检查更新',
            icon: Icons.vertical_align_top,
            onTap: checkVersion,
            ifBadge: topModel.versionManage.isLastest,
          ),
          SettingTile(
            title: '退出登录',
            icon: Icons.power_settings_new,
            onTap: () async {
              showConfirmDialog(context, content: "确认要退出登录 ?",
                  confirmCallback: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                CookieManager cookieManager = CookieManager();
                await cookieManager.clearCookies();
                Navigator.of(context).pushAndRemoveUntil(
                    new MaterialPageRoute(
                      builder: (BuildContext context) => new LoginPage(),
                    ),
                    (Route route) => route == null);
              });
            },
          ),
        ],
      ),
    );
  }
}
