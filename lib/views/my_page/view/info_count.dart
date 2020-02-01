import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/my_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/my_page/group/my_group_page.dart';

Widget infoCount(BuildContext context) {
  MyInfoData myInfo = topModel.myInfoManage.myInfoData;

  List<GroupData> groupList = topModel.myInfoManage.groupData.data;
  int groupLength = groupList.length;

  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          oneCount(context, "团队", groupLength, routeName: '/my/group'),
          oneCount(context, "知识库", myInfo.data.booksCount,
              routeName: '/my/repos'),
          oneCount(context, "关注了", myInfo.data.followingCount,
              routeName: '/my/following'),
          oneCount(context, "关注者", myInfo.data.followersCount,
              routeName: '/my/follower'),
        ],
      ),
    ),
  );
}

Widget oneCount(BuildContext context, String text, int len,
    {String routeName}) {
  return Container(
    width: 74,
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$len",
            textAlign: TextAlign.center,
            style: AppStyles.countStyle,
          ),
          Text(
            "$text",
            textAlign: TextAlign.center,
            style: AppStyles.countTextStyle,
          ),
        ],
      ),
    ),
  );
}
