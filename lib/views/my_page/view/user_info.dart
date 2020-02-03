import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/member.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/my_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

import 'info_count.dart';

Widget userInfo(BuildContext context) {
  MyInfoData myInfo = topModel.myInfoManage.myInfoData;
  String description = myInfo.data.description ?? "笔墨待识君";

  double leftMargin = (MediaQuery.of(context).size.width - 352) / 2;

  return Container(
    width: 352,
    margin: EdgeInsets.only(
        top: 60, left: leftMargin, right: leftMargin, bottom: leftMargin),
    padding: EdgeInsets.only(left: 28, right: 28, top: 16, bottom: 20),
    decoration: BoxDecoration(
      color: AppColors.background,
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(55, 0, 0, 0),
          offset: Offset(1, 2),
          blurRadius: 4,
        ),
      ],
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            myToast(context, "text");
          },
          child: aniRow(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16),
              userAvatar(myInfo.data.avatarUrl, height: 60),
              SizedBox(width: 16),
              Container(
                height: 84,
                width: 200,
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
                        style: AppStyles.countTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
        infoCount(context),
      ],
    ),
  );
}
