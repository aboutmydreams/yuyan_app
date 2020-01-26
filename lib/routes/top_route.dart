import 'package:flutter/material.dart';
import 'package:yuyan_app/views/begin_init/first_page/first_page.dart';
import 'package:yuyan_app/views/begin_init/guide_page/guide_page.dart';
import 'package:yuyan_app/views/begin_init/login_page/login_page.dart';
import 'package:yuyan_app/views/dashboard/dashboard.dart';
import 'package:yuyan_app/views/dashboard/quick/setting/quick_set.dart';
import 'package:yuyan_app/views/home_page.dart';
import 'package:yuyan_app/views/my_page/my_page.dart';
import 'package:yuyan_app/views/my_page/setting/setting_page.dart';

Map<String, WidgetBuilder> routeData = {
  '/': (context) => HomePage(),
  '/first': (context) => FirstPage(),
  '/login': (context) => LoginPage(),
  '/guide': (context) => GuidePage(),
  '/quickset': (context) => QuickSetPage(),
  '/dashboard': (context) => Dashboard(),
  '/my': (context) => MyPage(),
  '/my/setting': (context) => SettingPage(),
  // '/addcomment': (context) => AddComment(),
};
