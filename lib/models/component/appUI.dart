import 'package:flutter/material.dart';

// 白天主题
class AppColors {
  // 标题纯黑色
  static Color accentText = Colors.black;

  // 副标题
  static Color nextText = Colors.black87;

  // 主要文字段落灰色 纯黑的45%
  static Color primaryText = Colors.black45;

  // 页面背景
  static Color background = Colors.white;

  // 页面灰色背景
  static Color backgroundB = Color.fromRGBO(250, 250, 250, 1);

  // 首页的关注事件的背景颜色
  static Color eventBack = Color.fromRGBO(244, 244, 244, 1);

  // 我的页面数字背景颜色
  static Color yellow = Color.fromRGBO(255, 233, 151, 1);
}

// 文字样式 日间主题
class AppStyles {
  // 大标题
  static TextStyle textStyleA = TextStyle(
    color: AppColors.accentText,
    fontFamily: "sans_bold",
    fontWeight: FontWeight.w600,
    fontSize: 22,
  );

  // 各种动态标题文字样式
  static TextStyle textStyleB = TextStyle(
    color: AppColors.accentText,
    fontFamily: "sans_bold",
    fontWeight: FontWeight.w700,
    fontSize: 15,
  );

  // 各种动态用户名文字样式
  static TextStyle textStyleBB = TextStyle(
    color: AppColors.nextText,
    fontFamily: "sans_bold",
    fontWeight: FontWeight.w500,
    fontSize: 13,
  );

  // 各种动态内容文字样式
  static TextStyle textStyleC = TextStyle(
    color: Color.fromARGB(255, 89, 89, 89),
    height: 1.5,
    letterSpacing: 0.7,
    fontFamily: "sans_bold",
    fontWeight: FontWeight.w400,
    fontSize: 13,
  );

  // 各种动态内容文字样式
  static TextStyle textStyleCC = TextStyle(
    color: AppColors.primaryText,
    fontFamily: "sans_bold",
    fontWeight: FontWeight.w400,
    fontSize: 11,
  );

  // 我的页面数字样式
  static TextStyle countStyle = TextStyle(
    color: AppColors.primaryText,
    fontFamily: "sans_bold",
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );

  // 我的页面数字说明
  static TextStyle countTextStyle = TextStyle(
    color: AppColors.primaryText,
    fontFamily: "sans_bold",
    fontWeight: FontWeight.w700,
    fontSize: 12,
  );

  // 我的页面数字说明
  static TextStyle groupTextStyle = TextStyle(
    color: Colors.white70,
    fontFamily: "sans_bold",
    fontWeight: FontWeight.w600,
    fontSize: 15,
  );
}
