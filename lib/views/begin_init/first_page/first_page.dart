import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'dart:async';

import 'package:yuyan_app/state_manage/account/if_login.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

class FirstPage extends StatefulWidget {
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void initState() {
    super.initState();
    ifLogin().then((res) {
      if (res) {
        // 初始化数据
        topModel.update();
      }
    });

    // 定时器
    Timer timer = new Timer(
      const Duration(milliseconds: 3000),
      () {
        try {
          ifLogin().then((haveUserLogin) {
            print(haveUserLogin);
            if (haveUserLogin) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/", (route) => route == null);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/guide", (route) => route == null);
            }
          });
        } catch (e) {}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.7,
              child: Image.asset(
                'assets/images/first.jpg',
                fit: BoxFit.cover,
              ),
              color: Colors.green,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.3,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    child: Center(
                      child: Text(
                        "·  语燕",
                        style: AppStyles.textStyleB,
                      ),
                    ),
                  )
                ],
              ),
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
