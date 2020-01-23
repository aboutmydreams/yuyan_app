import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';

class MyGroup extends StatelessWidget {
  const MyGroup({Key key, this.groupList}) : super(key: key);

  final List<GroupData> groupList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的团队"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: groupList.length,
          itemBuilder: (BuildContext context, int index) {
            return oneSetQuick(context, groupList[index]);
          },
        ),
      ),
    );
  }
}

Widget oneSetQuick(BuildContext context, GroupData data) {
  String imageUrl = data.avatarUrl.toString().contains("http")
      ? data.avatarUrl
      : iconType[data.type] ?? "assets/images/explore/book.png";
  return GestureDetector(
    onTap: () {
      var url = "https://www.yuque.com/" + data.login;
      openUrl(context, url);
    },
    child: Container(
      height: 70,
      margin: EdgeInsets.only(top: 2, bottom: 9, left: 10, right: 10),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            offset: Offset(1, 2),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(9.5)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: userAvatar(imageUrl, height: 50),
          ),
          Text(
            data.name,
            style: AppStyles.textStyleB,
          )
        ],
      ),
    ),
  );
}

Map<String, String> iconType = {
  "Normal": "assets/images/dashboard/link.png",
  "Design": "assets/images/dashboard/design.png"
};
