import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/routes/top_route.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TopStateModel topModel = TopStateModel();
  topModel.getMyColor();
  runApp(MyApp(
    model: topModel,
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
        return MaterialApp(
          title: '语燕',
          initialRoute: '/login',
          debugShowCheckedModeBanner: false, // 去除debug标志
          routes: routeData,
          theme: ThemeData(
            platform: TargetPlatform.iOS, // 右滑返回
            primarySwatch: model.primarySwatchColor,
            highlightColor: Color.fromRGBO(255, 255, 255, 0.2),
            splashColor: Colors.white30,
            // accentColor: Color.fromRGBO(5, 254, 255, 1.0),
          ),
          // home: MyHomePage(),
        );
      },
    );
  }
}
