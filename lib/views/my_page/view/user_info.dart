import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/widgets_small/member.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/my_data.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/profile/profile_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

import 'info_count.dart';

Widget userInfo(BuildContext context) {
  MyInfoData myInfo = topModel.myInfoManage.myInfoData;
  ProfileData myProfile = topModel.myInfoManage.profileData;

  String job = myProfile.data.jobTitle ?? "雀友";
  String location = myProfile.data.location ?? "来自远方";
  String description = myInfo.data.description ?? "笔墨待识君";

  return Container(
      width: 352,
      // height: 240,
      padding: EdgeInsets.only(left: 28, right: 28, top: 16, bottom: 20),
      child: Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            userAvatar(myInfo.data.avatarUrl, height: 60),
            Spacer(),
            Container(
              width: 215,
              height: 84,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                        memberIcon(context),
                      ],
                    ),
                  ),
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
        infoCount(context),
      ]));
}
