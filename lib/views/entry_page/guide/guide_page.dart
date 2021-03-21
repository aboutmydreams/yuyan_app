import 'package:flare_flutter/flare_actor.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:flutter/material.dart';

import 'guide1.dart';
import 'guide2.dart';
import 'guide3.dart';

class GuidePage extends StatelessWidget {
  // int n = 0;

  final pages = [
    Container(child: Guide1()),
    Container(child: Guide2()),
    Container(child: Guide3()),
    // Container(child: LoginPage())
  ];

  pageChangeCallback(BuildContext context, int page) {
    // n += 1;
    // if ((n > 3) & (page == 2)) {
    //   print(n);
    //   Navigator.pushNamedAndRemoveUntil(
    //       context, "/login", (route) => route == null);
    // }
  }

  updateTypeCallback(UpdateType updateType) {
    print(updateType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        LiquidSwipe(
          pages: pages,
          fullTransitionValue: 230,
          enableSlideIcon: true,
          enableLoop: false,
          positionSlideIcon: 0.5,
          waveType: WaveType.liquidReveal,
          slideIconWidget: Icon(
            Icons.arrow_back_ios,
            color: Colors.cyan,
          ),
          // onPageChangeCallback: (page) => pageChangeCallback(context, page),
          // currentUpdateTypeCallback: (updateType) =>
          //     updateTypeCallback(updateType),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 35, top: 180),
              child: Container(
                width: 40,
                height: 40,
                child: FlareActor(
                  "assets/flares/progress.flr",
                  animation: "active",
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
