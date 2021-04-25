import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:yuyan_app/util/styles/app_ui.dart';

class NothingPage extends StatelessWidget {
  final String text;
  final double top;

  const NothingPage({
    Key key,
    this.top = 0,
    this.text = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: top,
            ),
            height: 240,
            child: FlareActor(
              "assets/flares/bird.flr",
              animation: "eye",
            ),
          ),
          Text(
            "$text",
            style: TextStyle(
              color: AppColors.primaryText,
              fontFamily: "sans_bold",
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 3,
            ),
          )
        ],
      ),
    );
  }
}
