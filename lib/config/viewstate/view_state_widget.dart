import 'dart:ui';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/models/component/appUI.dart';

class ViewErrorWidget extends StatelessWidget {
  final ViewError error;

  const ViewErrorWidget({
    Key key,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('error: $error'),
    );
  }
}

class ViewButtonWidget extends StatelessWidget {
  final Icon icon;
  final Widget child;
  final VoidCallback onPressed;

  const ViewButtonWidget({
    Key key,
    this.icon,
    this.child = const Text('刷新'),
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) icon,
          if (icon != null) SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            child: child,
          ),
        ],
      ),
    );
  }
}

class ViewEmptyWidget extends StatelessWidget {
  final Key key;
  final double top;
  final String tip;
  final Widget child;
  final double fontSize;

  const ViewEmptyWidget({
    this.key,
    this.top = 32,
    this.fontSize = 18,
    this.tip = '空空如也',
    this.child = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: top),
        Stack(
          children: [
            Container(
              height: 240,
              child: FlareActor(
                "assets/flares/bird.flr",
                animation: "eye",
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Text(
                "$tip",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "sans_bold",
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize,
                ),
              ),
            ),
          ],
        ),
        if (child != null)
          Container(
            padding: const EdgeInsets.all(4),
            child: child,
          ),
      ],
    );
  }
}

class ViewLoadingWidget extends StatelessWidget {
  const ViewLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 90,
        height: 90,
        child: FlareActor(
          "assets/flares/progress.flr",
          animation: "active",
        ),
      ),
    );
  }
}
