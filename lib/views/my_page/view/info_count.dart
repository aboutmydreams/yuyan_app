import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/my_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/my_page/group/my_group.dart';

Widget infoCount(BuildContext context) {
  MyInfoData myInfo = topModel.myInfoManage.myInfoData;

  List<GroupData> groupList = topModel.myInfoManage.groupData.data;
  int groupLength = groupList.length;

  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      width: 288,
      height: 70,
      margin: EdgeInsets.only(top: 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          oneCount(context, "团队", groupLength, callback: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return MyGroup(groupList: groupList);
            }));
          }),
          oneCount(context, "知识库", myInfo.data.booksCount),
          oneCount(context, "关注了", myInfo.data.followingCount),
          oneCount(context, "关注者", myInfo.data.followersCount),
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

Widget oneCount(BuildContext context, String text, int len,
    {Function callback}) {
  return InkWell(
    onTap: callback ?? () {},
    child: Container(
      width: 72,
      // height: 52,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Chip(
            label: Text(
              "$len",
              textAlign: TextAlign.center,
              style: AppStyles.countStyle,
            ),
            shadowColor: Colors.yellow,
            backgroundColor: Colors.yellow,
          ),
          // Spacer(),
          Text(
            "$text",
            textAlign: TextAlign.center,
            style: AppStyles.textStyleBB,
          ),
        ],
      ),
    ),
  );
}
