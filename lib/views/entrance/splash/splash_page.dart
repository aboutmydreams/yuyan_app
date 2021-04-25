import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/util/styles/app_ui.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      if (App.tokenProvider.isLogin) {
        Get.offAllNamed(RouteName.home);
      } else {
        Get.offAllNamed(RouteName.guide);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
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
                        style: AppStyles.textStyleBB,
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
