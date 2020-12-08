import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_info_data.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';
import 'package:yuyan_app/state_manage/dataManage/mydata_manage.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

class InfoCount extends StatelessWidget {
  const InfoCount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyInfoManage>(
        builder: (context, child, model) {
      UserInfoJson myInfo = model.myInfoData;
      List<GroupData> groupList = model.groupData.data;
      int groupLength = groupList.length;
      return Align(
        alignment: Alignment.topCenter,
        child: Container(
          child: aniRow(
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
    });
  }
}

Widget infoCount(BuildContext context) {
  return ScopedModelDescendant<MyInfoManage>(builder: (context, child, model) {
    UserInfoJson myInfo = model.myInfoData;
    List<GroupData> groupList = model.groupData.data;
    int groupLength = groupList.length;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        child: aniRow(
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
  });
}

Widget oneCount(BuildContext context, String text, int len,
    {String routeName}) {
  return Container(
    width: 64,
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
