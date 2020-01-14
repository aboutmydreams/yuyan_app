import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';

Widget userInfo() {
  return Container(
    width: 322,
    height: 92,
    margin: EdgeInsets.only(left: 24, top: 66),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 89,
          height: 92,
          child: ClipOval(
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Spacer(),
        Container(
          width: 215,
          height: 84,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 33,
                margin: EdgeInsets.only(left: 2),
                child: Row(
                  children: [
                    Text(
                      "邓文浩",
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyleA,
                    ),
                    Container(
                      width: 21,
                      height: 23,
                      margin: EdgeInsets.only(left: 13),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(20, 0, 0, 0),
                            offset: Offset(0, 2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/images/my_page/member.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "assets/images/my_page/exit.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 17,
                margin: EdgeInsets.only(top: 8, right: 17),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      margin: EdgeInsets.only(right: 2),
                      child: Image.asset(
                        "assets/images/my_page/location.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 3),
                      child: Text(
                        "NCUHOME",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.accentText,
                          fontFamily: "PingFang SC",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 22,
                      height: 22,
                      child: Image.asset(
                        "assets/images/my_page/position.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      "经常看天的产品",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.accentText,
                        fontFamily: "PingFang SC",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(left: 3),
                child: Text(
                  "to develop more love",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: "PingFang SC",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
