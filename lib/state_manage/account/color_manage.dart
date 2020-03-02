import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuyan_app/models/tools/get_pref.dart';

class ColorManage extends Model {
  static List<MaterialColor> _colorList = [
    // Colors.yellow,
    // Colors.orange,
    Colors.deepOrange,
    // Colors.amber,
    Colors.blue,
    Colors.red,
    Colors.pink,
    // Colors.lime,
    // Colors.lightGreen,
    Colors.green,
    Colors.teal,
    // Colors.cyan,
    // Colors.indigo,
    Colors.purple,
    Colors.deepPurple,
    // Colors.grey,
    Colors.blueGrey,
    Colors.brown,
  ];

  int nowColor;
  MaterialColor _primarySwatchColor;
  MaterialColor get primarySwatchColor => _primarySwatchColor;

  ThemeData _themeData;
  ThemeData get themeData => _themeData;

  bool _hideBottomBar = true;
  bool get hideBottomBar => _hideBottomBar;

  static saveColor(int colorNum) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("primarySwatchColor", colorNum);
    return 1;
  }

  getMyColor() async {
    var _myColor = await getPrefIntData("primarySwatchColor");
    _myColor ??= 0;
    _primarySwatchColor = _colorList[_myColor];
    notifyListeners();
    return _myColor;
  }

  getMyTheme() {
    _themeData = ThemeData(
      platform: TargetPlatform.iOS, // 右滑返回
      primarySwatch: _primarySwatchColor,
      highlightColor: Color.fromRGBO(255, 255, 255, 0.3),
      splashColor: Colors.white12,
      accentColor: Color.fromRGBO(25, 25, 25, 0.8),
    );

    notifyListeners();
    return 1;
  }

  void changeColor() {
    getMyColor().then((res) {
      var nowColor = res;
      nowColor++;

      if (nowColor == null) {
        nowColor = 0;
        saveColor(0);
      }
      if (nowColor == _colorList.length) {
        nowColor = 0;
      }

      _primarySwatchColor = _colorList[nowColor];
      print(_primarySwatchColor);

      // Sava the color num
      saveColor(nowColor).then((res) async {
        print("saveNowColor===");
        print(nowColor);
        print("saveNowColor==");
        getMyTheme();
        return 1;
      }).then((res) {
        notifyListeners();
        print("noti again");
      });
      // Then notify all the listeners.
      notifyListeners();
      debugPrint("notifyListeners!!!");
    });
  }
}
