import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/my_data.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/profile/profile_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

Widget userInfo(BuildContext context) {
  MyInfoData myInfo = topModel.myInfoManage.myInfoData;
  ProfileData myProfile = topModel.myInfoManage.profileData;

  String job = myProfile.data.jobTitle ?? "雀友";
  String location = myProfile.data.location ?? "来自远方";
  String description = myInfo.data.description ?? "笔墨待识君";

  return Container(
    width: 322,
    height: 92,
    margin: EdgeInsets.only(left: 24, top: 66),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        userAvatar(myInfo.data.avatarUrl, height: 90),
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
                      "${myInfo.data.name}",
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyleA,
                    ),
                    // 会员
                    GestureDetector(
                      child: Container(
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
                    ),
                    Spacer(),
                    Container(
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.only(right: 20),
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
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(left: 3),
                child: Text(
                  "$description",
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
