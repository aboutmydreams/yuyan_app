import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

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
    // pageList
    // ..add(HomeScreen())
    // ..add(AirScreen())
    // ..add(MyScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: Container(
        color: Colors.blueAccent,
        child: Center(
          child: Column(
            children: <Widget>[
              // Container(
              //   width: MediaQuery.of(context).size.width * 0.1,
              //   child: FlareActor(
              //     "assets/flares/yuyan_first.flr",
              //     animation: "peace",
              //     alignment: Alignment.topCenter,
              //     fit: BoxFit.contain,
              //   ),
              // ),
              Text(_page.toString(), textScaleFactor: 10.0),
              RaisedButton(
                child: Text('Go To Page of indexs 1'),
                onPressed: () {
                  //Page change using state does the same as clicking index 1 navigation button
                  final CurvedNavigationBarState navBarState =
                      _bottomNavigationKey.currentState;
                  navBarState.setPage(1);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
