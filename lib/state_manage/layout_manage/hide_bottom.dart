import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class BottomNavigatorController extends GetxController
    with SingleGetTickerProviderMixin {
  AnimationController _animateController;
  Duration _duration = Duration(milliseconds: 300);

  Animation get animation => CurvedAnimation(
        parent: _animateController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.bounceIn,
      );

  double get height => _animateController.value;

  addScrollListener(ScrollController controller) {
    var listener = () {
      switch (controller.position.userScrollDirection) {
        case ScrollDirection.forward:
          _animateController.forward();
          break;
        case ScrollDirection.reverse:
          _animateController.reverse();
          break;
        default:
      }
    };
    controller.addListener(listener);
  }

  @override
  void onInit() {
    super.onInit();
    _animateController = AnimationController(
      value: 56,
      lowerBound: 0,
      upperBound: 56,
      duration: _duration,
      vsync: this,
    );
  }
}
