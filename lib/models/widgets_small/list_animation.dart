import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

Widget animationChild({int index, Widget child}) {
  return AnimationConfiguration.staggeredList(
    position: index,
    duration: const Duration(milliseconds: 375),
    child: SlideAnimation(
      verticalOffset: 50.0,
      child: FadeInAnimation(
        child: child,
      ),
    ),
  );
}
