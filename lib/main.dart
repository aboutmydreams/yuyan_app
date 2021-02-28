import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/models/tools/analytics.dart';
import 'file:///D:/Documents/GitHub/flutter/yuyan_app/lib/config/route_manager.dart';
import 'package:yuyan_app/state_manage/layout_manage/hide_bottom.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

TopStateModel topModel1 = topModel;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //所有的init不能throw错误，否则App无法正常启动
  await StorageManager.init();
  await topModel1.getMyColor();
  await topModel1.getMyTheme();
  await App.init();
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
      child: MyMaterialApp(),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TopStateModel>(
      builder: (context, child, model) {
        print("build again!");
        return GetMaterialApp(
          title: '语燕',
          initialRoute: '/first',
          debugShowCheckedModeBanner: false, // 去除debug标志
          getPages: MyRoute.pages,
          theme: model.themeData,
          navigatorObservers: <NavigatorObserver>[observer], //加入路由统计
          // home: MyHomePage(),
          initialBinding: BindingsBuilder(() {
            // Get.lazyPut(() => BottomManagerController(), fenix: true);
            Get.put(BottomManagerController());
          }),
        );
      },
    );
  }
}
