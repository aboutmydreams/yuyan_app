import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class FirstPage extends StatefulWidget {
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void initState() {
    super.initState();
    getAdData();
    Timer timer = new Timer(
      const Duration(milliseconds: 3000),
      () {
        try {
          Navigator.pushNamedAndRemoveUntil(
              context, "/", (route) => route == null);
        } catch (e) {}
      },
    );
  }

  getAdData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.3,
              child: Text("YuYan"),
              color: Colors.green,
            ),
          ),
          // Positioned(
          //   // top: 20,
          //   child: Container(
          //     // padding:
          //     //     EdgeInsets.only(top: -MediaQuery.of(context).padding.top),
          //     width: MediaQuery.of(context).size.width,
          //     height: MediaQuery.of(context).size.height,
          //     child: FlareActor(
          //       "assets/flares/yuyan_first.flr",
          //       animation: "peace",
          //       alignment: Alignment.center,
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
