import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/my_page/view/bottom_column.dart';
import 'package:yuyan_app/views/my_page/view/user_info.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      userInfo(context),
      threeWidget(context),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          // 背景图形
          Positioned(
            top: 0,
            child: ClipPath(
              clipper: ArcClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.33,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: topModel.primarySwatchColor,
                  gradient: LinearGradient(
                      colors: [
                        topModel.primarySwatchColor,
                        topModel.primarySwatchColor.withAlpha(60)
                      ],
                      begin: FractionalOffset(0, 0),
                      end: FractionalOffset(0, 1)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(55, 0, 0, 0),
                      offset: Offset(1, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 100,
              child: ListView.builder(
                  controller: _controller,
                  itemCount: widgetList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return widgetList[index];
                  }),
            ),
          )
        ],
      ),
    );
  }
}
