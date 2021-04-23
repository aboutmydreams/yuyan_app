import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/controller/binding/app_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //所有的 init 不能 throw 错误，否则 App 无法正常启动
  await App.init();
  if (Platform.isAndroid) {
    /// https://www.geek-share.com/detail/2799306029.html
    /// 以下两行 设置android状态栏为透明的沉浸。
    /// 写在组件渲染之后，是为了在渲染后进行 set 赋值，
    /// 覆盖状态栏，写在渲染之前 MaterialApp 组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TransitionBuilder toastBuilder = BotToastInit();

  @override
  Widget build(BuildContext context) {
    print("build again!");

    App.analytics.logEvent(
      name: 'dev_myapp',
      parameters: {
        "a": 1,
      },
    );

    App.analytics.logAppOpen();

    return GetMaterialApp(
      title: '语燕',
      initialRoute: RouteName.splash,
      debugShowCheckedModeBanner: false,
      getPages: MyRoute.pages,
      // themeMode: ThemeMode.dark,
      // darkTheme: ThemeData.dark(),
      navigatorObservers: <NavigatorObserver>[
        BotToastNavigatorObserver(),
        FirebaseAnalyticsObserver(analytics: App.analytics),
      ],
      initialBinding: AppBinding(),
      defaultTransition: Transition.cupertino,
      builder: _builder,
    );
  }

  Widget _builder(BuildContext context, Widget child) {
    final toast = toastBuilder(context, child);
    final keyboard = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (Get.focusScope.hasPrimaryFocus) {
          Get.focusScope.unfocus();
        }
      },
      child: toast,
    );
    return ScrollConfiguration(
      behavior: _ScrollBehavior(),
      child: keyboard,
    );
  }
}

class _ScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(context, child, _) => child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return BouncingScrollPhysics(
      parent: RangeMaintainingScrollPhysics(),
    );
  }
}
