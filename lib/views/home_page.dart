import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/views/my_page/my_page.dart';
import 'dart:ui';

import 'explore_page/explore_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  List<Widget> pageList = List();
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    pageList..add(ExplorePage())..add(MyPage())..add(MyPage())..add(MyPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        color: Colors.yellow,
        animationCurve: Curves.easeInQuad,
        height: 64,
        backgroundColor: Colors.transparent,
        items: <Widget>[
          Icon(Icons.insert_emoticon, size: 34),
          Icon(Icons.wrap_text, size: 34),
          Icon(Icons.notifications_none, size: 34),
          Icon(Icons.perm_identity, size: 34),
        ],
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: pageList[_page],
    );
  }
}
