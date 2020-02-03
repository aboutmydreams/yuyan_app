import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

Widget animationList(
    {BuildContext context,
    ScrollController controller,
    List dataList,
    Function childBuilder}) {
  return AnimationLimiter(
    child: ListView.builder(
      controller: controller,
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: childBuilder(context, dataList[index]),
            ),
          ),
        );
      },
    ),
  );
}

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

Widget aniColumn({
  List<Widget> children,
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.center,
}) {
  return AnimationLimiter(
    child: Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: AnimationConfiguration.toStaggeredList(
        duration: const Duration(milliseconds: 375),
        childAnimationBuilder: (widget) => SlideAnimation(
          horizontalOffset: 50.0,
          child: FadeInAnimation(
            child: widget,
          ),
        ),
        children: children,
      ),
    ),
  );
}

Widget aniRow({
  List<Widget> children,
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.center,
}) {
  return AnimationLimiter(
    child: Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: AnimationConfiguration.toStaggeredList(
        duration: const Duration(milliseconds: 375),
        childAnimationBuilder: (widget) => SlideAnimation(
          horizontalOffset: 50.0,
          child: FadeInAnimation(
            child: widget,
          ),
        ),
        children: children,
      ),
    ),
  );
}
