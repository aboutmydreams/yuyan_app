import 'package:flutter/material.dart';
import 'package:yuyan_app/views/my_page/view/bottom_column.dart';
import 'package:yuyan_app/views/my_page/view/info_count.dart';
import 'package:yuyan_app/views/my_page/view/user_info.dart';
import 'package:yuyan_app/views/my_page/view/user_own.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[userInfo(), infoCount(), infoOwn(), threeWidget()],
        ),
      ),
    );
  }
}
