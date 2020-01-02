import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';

Widget threeWidget() {
  return Container(
    child: Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 250,
            height: 59,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.background,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 187, 187, 187),
                  offset: Offset(1, 2),
                  blurRadius: 4,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(29.5)),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 22),
                  child: Text(
                    "意见与反馈",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.accentText,
                      fontFamily: "PingFang SC",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: 16,
                  height: 16,
                  margin: EdgeInsets.only(right: 16),
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
