import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuyan_app/models/tools/get_pref.dart';
import 'package:yuyan_app/state_manage/account/color_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/attent_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/mydata_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/news_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/quick_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/recent_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/select_manage.dart';

class TopStateModel extends ColorManage {
  // ColorManage colorManage = ColorManage();
  // static List<MaterialColor> _colorList = [
  //   Colors.yellow,
  //   Colors.orange,
  //   Colors.deepOrange,
  //   Colors.amber,
  //   Colors.blue,
  //   Colors.red,
  //   Colors.pink,
  //   Colors.lime,
  //   Colors.lightGreen,
  //   Colors.green,
  //   Colors.teal,
  //   Colors.cyan,
  //   Colors.indigo,
  //   Colors.purple,
  //   Colors.deepPurple,
  //   Colors.grey,
  //   Colors.blueGrey,
  //   Colors.brown,
  // ];

  // int nowColor;
  // MaterialColor _primarySwatchColor;
  // MaterialColor get primarySwatchColor => _primarySwatchColor;

  // ThemeData _themeData;
  // ThemeData get themeData => _themeData;

  // static saveColor(int colorNum) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt("primarySwatchColor", colorNum);
  //   return 1;
  // }

  // getMyColor() async {
  //   var _myColor = await getPrefIntData("primarySwatchColor");
  //   _myColor ??= 0;
  //   _primarySwatchColor = _colorList[_myColor];
  //   notifyListeners();
  //   return _myColor;
  // }

  // getMyTheme() {
  //   _themeData = ThemeData(
  //     platform: TargetPlatform.iOS, // 右滑返回
  //     primarySwatch: _primarySwatchColor,
  //     highlightColor: Color.fromRGBO(255, 255, 255, 0.9),
  //     splashColor: Colors.yellow,
  //     accentColor: Color.fromRGBO(25, 25, 25, 1.0),
  //   );
  //   print("theme");
  //   notifyListeners();
  //   return 1;
  // }

  // void changeColor() {
  //   getMyColor().then((res) {
  //     var nowColor = res;
  //     nowColor++;

  //     if (nowColor == null) {
  //       nowColor = 0;
  //       saveColor(0);
  //     }
  //     if (nowColor == _colorList.length) {
  //       nowColor = 0;
  //     }

  //     _primarySwatchColor = _colorList[nowColor];
  //     print(_primarySwatchColor);

  //     // Sava the color num
  //     saveColor(nowColor).then((res) async {
  //       print("saveNowColor===");
  //       print(nowColor);
  //       print("saveNowColor==");
  //       getMyTheme();
  //       notifyListeners();
  //       return 1;
  //     }).then((res) {
  //       notifyListeners();
  //       print("noti again");
  //     });
  //     // Then notify all the listeners.
  //     notifyListeners();
  //     print("notifyListeners!!!");
  //   });
  // }

  SelectManage selectManage = SelectManage();
  AttentManage attentManage = AttentManage();
  NewsManage newsManage = NewsManage();
  QuickManage quickManage = QuickManage();
  RecentManage recentManage = RecentManage();
  MyInfoManage myInfoManage = MyInfoManage();

  /// 初始化数据
  void update() {
    // 关注数据
    attentManage.update();
    // 精选数据
    selectManage.update();
    // 快捷入口
    quickManage.update();
    // 最近数据
    recentManage.update();
    // 消息数据
    newsManage.update();
    // 我的数据
    myInfoManage.update();
  }
}

TopStateModel topModel = TopStateModel();

// class Name1 extends TopStateModel {}
