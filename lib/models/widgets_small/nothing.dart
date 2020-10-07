import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yuyan_app/models/component/appUI.dart';

class NothingPage extends StatelessWidget {
  const NothingPage({Key key, this.top: 0, this.text: ""}) : super(key: key);
  final String text;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: top),
            child: SvgPicture.asset(
              "assets/images/nothing/research.svg",
              height: MediaQuery.of(context).size.width * 0.6,
              width: MediaQuery.of(context).size.width * 0.6,
              semanticsLabel: 'paddy',
            ),
          ),
          SizedBox(height: 30),
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
