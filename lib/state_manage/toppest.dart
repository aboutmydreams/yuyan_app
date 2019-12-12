import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TopStateModel extends Model {
  static List<MaterialColor> _colorList = [
    Colors.blue,
    Colors.red,
    Colors.pink,
    Colors.orange,
    Colors.deepOrange,
    Colors.amber,
    Colors.yellow,
    Colors.lime,
    Colors.lightGreen,
    Colors.green,
    Colors.teal,
    Colors.cyan,
    Colors.indigo,
    Colors.purple,
    Colors.deepPurple,
    Colors.grey,
    Colors.blueGrey,
    Colors.brown,
  ];

  int nowColor;
  MaterialColor _primarySwatchColor;
  MaterialColor get primarySwatchColor => _primarySwatchColor;

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
      saveColor(nowColor).then((res) {
        print("saveNowColor===");
        print(nowColor);
        print("saveNowColor==");
      });
      // Then notify all the listeners.
      notifyListeners();
      debugPrint("notifyListeners!!!");
    });
  }
}
