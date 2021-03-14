import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/controller/binding/app_binding.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/util/analytics.dart';

TopStateModel topModel1 = topModel;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //所有的init不能throw错误，否则App无法正常启动
  await StorageManager.init();
  await App.init();
  if (Platform.isAndroid) {
    /// https://www.geek-share.com/detail/2799306029.html
    /// 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("build again!");
    final botToastBuilder = BotToastInit();
    return GetMaterialApp(
      title: '语燕',
      initialRoute: RouteName.splash,
      debugShowCheckedModeBanner: false,
      // 去除debug标志
      getPages: MyRoute.pages,
      navigatorObservers: <NavigatorObserver>[
        observer,
        BotToastNavigatorObserver(),
      ],
      //加入路由统计
      // home: MyHomePage(),
      initialBinding: AppBinding(),
      builder: (context, child) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (Get.focusScope.hasPrimaryFocus) {
              Get.focusScope.unfocus();
            }
          },
          child: botToastBuilder(
            context,
            ScopedModel<TopStateModel>(
              model: topModel1,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
