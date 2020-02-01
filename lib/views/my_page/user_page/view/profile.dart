import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/profile/profile_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

Widget profileWidget() {
  ProfileData myProfile = topModel.myInfoManage.profileData;
  String job = myProfile.data.jobTitle ?? "雀友";
  String location = myProfile.data.location ?? "来自远方";

  return Container(
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
            "$location",
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
          "$job",
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
  );
}
