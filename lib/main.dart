import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/tools/analytics.dart';
import 'package:yuyan_app/routes/top_route.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

TopStateModel topModel1 = topModel;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await topModel1.getMyColor();
  await topModel1.getMyTheme();
  if (Platform.isAndroid) {
    /// https://www.geek-share.com/detail/2799306029.html
    /// 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MyApp(
    model: topModel1,
  ));
}

class MyApp extends StatelessWidget {
  final TopStateModel model;

  const MyApp({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<TopStateModel>(
      model: model,
      child: MyMeterialApp(),
    );
  }
}

class MyMeterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TopStateModel>(
      builder: (context, child, model) {
        print("build again!");
        return MaterialApp(
          title: '语燕',
          initialRoute: '/first',
          debugShowCheckedModeBanner: false, // 去除debug标志
          routes: routeData,
          theme: model.themeData,
          navigatorObservers: <NavigatorObserver>[observer], //加入路由统计
          // home: MyHomePage(),
        );
      },
    );
  }
}
