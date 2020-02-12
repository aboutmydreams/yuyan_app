import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

class MyGroup extends StatelessWidget {
  const MyGroup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<GroupData> groupList = topModel.myInfoManage.groupData.data;

    return Scaffold(
      appBar: AppBar(
        title: Text("我的团队"),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: groupList.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: oneSetQuick(context, groupList[index]),
                ),
              ),
            );
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
  data.avatarUrl = imageUrl;
  return GestureDetector(
    onTap: () {
      // var url = "https://www.yuque.com/" + data.login;
      // openUrl(context, url);
      OpenPage.group(context, groupdata: data);
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
            child: Hero(
                tag: data.id, child: userAvatar(data.avatarUrl, height: 50)),
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
