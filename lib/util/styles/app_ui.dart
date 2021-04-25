import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/controller/app/theme_controller.dart';

// 白天主题
class AppColors {
  // 标题纯黑色
  static Color accentText = Colors.black;

  // 副标题
  static Color nextText = Colors.black87;

  // 副标题
  static Color nextText2 = Colors.black54;

  // 主要文字段落灰色 纯黑的45%
  static Color primaryText = Colors.black45;

  static Color get primary => ThemeController.to.primarySwatchColor;

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
    fontWeight: FontWeight.w500,
    fontSize: 22,
  );

  // 各种动态标题文字样式
  static TextStyle textStyleB = TextStyle(
    color: AppColors.accentText,
    fontFamily: "sans_bold",
    fontWeight: FontWeight.w700,
    fontSize: 15,
  );

  // 各种动态标题文 文档评论标题 字样式
  static TextStyle textStyleBp = TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  // 我的页面 下方文字 较细
  static TextStyle textStyleBC = TextStyle(
    color: AppColors.accentText,
    fontFamily: "sans_bold",
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  // 各种动态用户名文字样式
  static TextStyle textStyleBB = TextStyle(
    color: AppColors.nextText,
    fontFamily: "sans_bold",
    fontWeight: FontWeight.w500,
    fontSize: 13,
  );

  // 各种动态用户名文字样式
  static TextStyle textStyleBBB = TextStyle(
    color: AppColors.nextText2,
    fontFamily: "sans_bold",
    fontWeight: FontWeight.w400,
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

  // 各种动态内容文字样式
  static TextStyle textStyleCB = TextStyle(
    color: AppColors.primaryText,
    fontFamily: "sans_bold",
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  // 我的页面数字样式
  static TextStyle countStyle = TextStyle(
    color: AppColors.nextText,
    fontFamily: "sans_bold",
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );

  // 我的页面数字说明
  static TextStyle countTextStyle = TextStyle(
    color: AppColors.primaryText,
    fontFamily: "sans_bold",
    fontWeight: FontWeight.w500,
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

class AppIcon {
  static Widget iconType(
    String iconName, {
    double size,
    VoidCallback onTap,
  }) {
    Map<String, Icon> iconDic = {
      "doc": Icon(
        Icons.description,
        color: Colors.deepPurpleAccent,
        size: size,
      ),
      "book": Icon(
        Icons.book,
        color: Colors.blue,
        size: size,
      ),
      "sheet": Icon(
        Icons.event_note,
        color: Colors.green,
        size: size,
      ),
      "thread": Icon(
        Icons.speaker_notes,
        color: Colors.blue,
        size: size,
      ),
      "group": Icon(
        Icons.group,
        color: Colors.grey,
        size: size,
      ),
      "design": Icon(
        Icons.collections,
        color: Colors.orangeAccent,
        size: size,
      ),
      "resource": Icon(
        Icons.create_new_folder,
        color: Colors.deepOrange,
        size: size,
      ),
      "column": Icon(
        Icons.chrome_reader_mode,
        color: Colors.deepOrange,
        size: size,
      ),
      //TODO add `Mind` type
      "mind": Icon(
        Icons.error,
        color: Colors.red,
        size: size,
      ),
      "file": Icon(
        Icons.attach_file,
        color: Colors.blue,
        size: size,
      ),
      "fullscreen": Icon(
        Icons.fullscreen,
        color: Colors.blue,
        size: size,
      ),
      "exit_fullscreen": Icon(
        Icons.close_fullscreen,
        color: Colors.blue,
        size: size,
      ),
    };
    final fallback = IconButton(
      icon: Icon(
        Icons.error,
        size: size,
      ),
      color: Colors.red,
      onPressed: () {
        BotToast.showText(text: 'iconName: $iconName not mapped to an icon!');
      },
    );
    var iconWidget = iconDic[iconName?.toLowerCase()];
    if (iconWidget == null) return fallback;
    if (onTap == null) return iconWidget;
    return InkWell(
      onTap: onTap,
      child: iconWidget,
    );
  }
}
