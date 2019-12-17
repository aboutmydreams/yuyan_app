import 'package:flutter/material.dart';
import 'package:yuyan_app/views/begin_init/first_page/first_page.dart';
import 'package:yuyan_app/views/begin_init/guide_page/guide_page.dart';
import 'package:yuyan_app/views/begin_init/login_page/login_page.dart';
import 'package:yuyan_app/views/home_page.dart';

Map<String, WidgetBuilder> routeData = {
  '/': (context) => HomePage(),
  '/first': (context) => FirstPage(),
  '/login': (context) => LoginPage(),
  '/guide': (context) => GuidePage(),
  // '/setting': (context) => SettingPage(),
  // '/aboutwork': (context) => AboutWorkPage(),
  // '/addtopic': (context) => AddTopicPage(),
  // '/my': (context) => MyPage(),
  // '/addcomment': (context) => AddComment(),
};
