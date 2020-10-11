import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';

Widget oneGroup(BuildContext context, GroupData data,
    {int index, EdgeInsets margin}) {
  String imageUrl = data.avatarUrl.toString().contains("http")
      ? data.avatarUrl
      : iconType[data.type] ?? "assets/images/explore/book.png";
  data.avatarUrl = imageUrl;
  margin = margin ?? EdgeInsets.only(top: 2, bottom: 9, left: 10, right: 10);
  return GestureDetector(
    onTap: () {
      OpenPage.group(context, groupdata: data, pageIndex: index ?? 0);
    },
    child: Container(
      height: 70,
      margin: margin,
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
