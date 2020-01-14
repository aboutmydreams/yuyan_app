import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';

Widget infoCount() {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      width: 289,
      height: 52,
      margin: EdgeInsets.only(top: 28),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 52,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 22,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 9,
                        right: 9,
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.yellow,
                            boxShadow: [
                              Shadows.primaryShadow,
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(),
                        ),
                      ),
                      Positioned(
                        left: 17,
                        right: 17,
                        child: Text(
                          "7",
                          textAlign: TextAlign.center,
                          style: AppStyles.countStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  "团队语",
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyleB,
                ),
              ],
            ),
          ),
          Container(
            width: 45,
            height: 52,
            margin: EdgeInsets.only(left: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 21,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 7,
                        right: 8,
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.yellow,
                            boxShadow: [
                              Shadows.primaryShadow,
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(),
                        ),
                      ),
                      Positioned(
                        left: 13,
                        right: 13,
                        child: Text(
                          "10",
                          textAlign: TextAlign.center,
                          style: AppStyles.countStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  "知识库",
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyleB,
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            width: 48,
            height: 52,
            margin: EdgeInsets.only(right: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 21,
                  margin: EdgeInsets.only(left: 2, right: 1),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 7,
                        right: 8,
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.yellow,
                            boxShadow: [
                              Shadows.primaryShadow,
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(),
                        ),
                      ),
                      Positioned(
                        left: 13,
                        right: 13,
                        child: Text(
                          "26",
                          textAlign: TextAlign.center,
                          style: AppStyles.countStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  child: Text(
                    "关注了",
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyleB,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 46,
            height: 52,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 21,
                  margin: EdgeInsets.only(left: 1),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 7,
                        right: 8,
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.yellow,
                            boxShadow: [
                              Shadows.primaryShadow,
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(),
                        ),
                      ),
                      Positioned(
                        left: 13,
                        right: 13,
                        child: Text(
                          "58",
                          textAlign: TextAlign.center,
                          style: AppStyles.countStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(right: 1),
                  child: Text(
                    "关注者",
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyleB,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class Shadows {
  Color primaryElement = Colors.white12;
  static BoxShadow primaryShadow = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.3),
    offset: Offset(0, 0),
    blurRadius: 2,
  );
}
