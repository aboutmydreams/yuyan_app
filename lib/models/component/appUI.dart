import 'package:flutter/material.dart';

class AppColors {
  static Color accentText = Colors.black;
  static Color primaryText = Colors.black45;
  static Color background = Colors.white;
}

class AppStyles {
  static TextStyle textStyleA = TextStyle(
    color: AppColors.accentText,
    fontFamily: "PingFang SC",
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );
  static TextStyle textStyleB = TextStyle(
    color: Colors.black,
    fontFamily: "PingFang SC",
    fontWeight: FontWeight.w600,
    fontSize: 15,
  );

  static TextStyle textStyleC = TextStyle(
    color: AppColors.primaryText,
    fontFamily: "PingFang SC",
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
}
