import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/storage_manager.dart';

class ThemeController extends GetxController {
  final _indexKey = "primarySwatchColor";

  static ThemeController get to => Get.find();
  static List<MaterialColor> _definedColors = [
    // Colors.yellow,
    // Colors.orange,

    Colors.blue,
    Colors.teal,
    Colors.deepOrange,
    // Colors.amber,
    Colors.red,
    Colors.pink,
    // Colors.lime,
    // Colors.lightGreen,
    Colors.green,
    // Colors.cyan,
    // Colors.indigo,
    Colors.purple,
    Colors.deepPurple,
    // Colors.grey,
    Colors.blueGrey,
    Colors.brown,
  ];

  int _colorIndex;
  MaterialColor _primarySwatchColor;
  ThemeData _themeData;

  MaterialColor get primarySwatchColor => _primarySwatchColor;

  ThemeData get themeData => _themeData;

  onInit() {
    super.onInit();

    loadColorIndex();
    updateThemeData();
    Get.changeTheme(themeData);
  }

  saveColorIndex() async {
    var prefs = StorageManager.sharedPreferences;
    prefs.setInt(_indexKey, _colorIndex);
  }

  loadColorIndex() {
    _colorIndex = StorageManager.sharedPreferences.getInt(_indexKey) ?? 0;
    _primarySwatchColor = _definedColors[_colorIndex];
  }

  updateThemeData() {
    _themeData = ThemeData(
      // platform: TargetPlatform.iOS, //这个iOS力学平台在安卓上会报错，这里取消掉！
      // 右滑返回
      scrollbarTheme: ScrollbarThemeData(
        radius: Radius.circular(16),
        thumbColor: MaterialStateProperty.all(Colors.grey),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
      ),
      primarySwatch: _primarySwatchColor,
      highlightColor: Color.fromRGBO(255, 255, 255, 0.3),
      splashColor: Colors.white12,
      accentColor: Color.fromRGBO(25, 25, 25, 0.8),
    );
  }

  changeThemeColor() {
    _colorIndex = (_colorIndex + 1) % _definedColors.length;
    _primarySwatchColor = _definedColors[_colorIndex];
    updateThemeData();
    saveColorIndex();
    Get.changeTheme(themeData);
    update();
  }
}
