import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/views/begin_init/guide_page/guide1.dart';
import 'package:yuyan_app/views/begin_init/guide_page/guide2.dart';
import 'package:yuyan_app/views/begin_init/guide_page/guide3.dart';

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
      body: LiquidSwipe(
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
    );
  }
}
