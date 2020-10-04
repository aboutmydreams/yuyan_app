import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_info_data.dart';
import 'package:yuyan_app/models/tools/get_tag.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/member.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

import 'info_count.dart';

Widget userInfo(BuildContext context) {
  TheInfo myInfo = topModel.myInfoManage.myInfoData.data ??
      TheInfo(description: "笔墨待识君", avatarUrl: "");

  double leftMargin = MediaQuery.of(context).size.width * 0.075;
  double descriptionWidth =
      MediaQuery.of(context).size.width - leftMargin * 3.6 - 95;
  String tag = getTag();

  return Container(
    margin: EdgeInsets.only(
        top: 40, left: leftMargin, right: leftMargin, bottom: leftMargin),
    padding: EdgeInsets.only(
        left: leftMargin * 0.8, right: leftMargin * 0.8, top: 14, bottom: 18),
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
          onTap: () async {
            OpenPage.user(
              context,
              login: myInfo.login,
              tag: tag,
              userId: myInfo.id,
              description: myInfo.description,
              name: myInfo.name,
              avatarUrl: myInfo.avatarUrl,
            );
          },
          child: aniRow(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 16),
              Hero(
                tag: tag,
                child: userAvatar(myInfo.avatarUrl, height: 60),
              ),
              SizedBox(width: 16),
              Container(
                height: 84,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 33,
                      width: descriptionWidth,
                      margin: EdgeInsets.only(left: 2),
                      child: Row(
                        children: [
                          Text(
                            "${myInfo.name}",
                            textAlign: TextAlign.center,
                            style: AppStyles.textStyleA,
                          ),
                          // 会员
                          memberIcon(context),
                        ],
                      ),
                    ),
                    Container(
                      width: descriptionWidth,
                      margin: EdgeInsets.only(left: 3),
                      child: Text(
                        "${myInfo.description}",
                        textAlign: TextAlign.left,
                        maxLines: 2,
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
        InfoCount(),
      ],
    ),
  );
}
