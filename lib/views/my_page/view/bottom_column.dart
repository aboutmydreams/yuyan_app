import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/controller/version_controller.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

Widget threeWidget(BuildContext context) {
  return Container(
    child: aniColumn(
      children: <Widget>[
        oneColumn(context,
            imgName: "collections", text: "我的收藏", routeName: "/my/mark"),
        oneColumn(context,
            imgName: "follow_book",
            text: "关注知识库",
            routeName: "/my/follow_book"),
        oneColumn(context,
            imgName: "topics", text: "我的讨论", routeName: "/my/topic"),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 10,
          color: Color.fromRGBO(0, 0, 0, 0.03),
        ),
        oneColumn(context,
            imgName: "suggest", text: "意见与反馈", routeName: "/my/suggest"),
        oneColumn(context,
            imgName: "about", text: "关于语燕", routeName: "/my/about"),
        Obx(() {
          return oneColumn(
            context,
            imgName: "setting",
            text: "设置",
            routeName: "/my/setting",
            ifBadge: Get.find<VersionController>().isLatest,
          );
        }),
      ],
    ),
  );
}

Widget oneColumn(BuildContext context,
    {String text, String imgName, String routeName, bool ifBadge: false}) {
  return ListTile(
    leading: Container(
      margin: EdgeInsets.only(left: 24),
      child: Image.asset(
        'assets/images/my_page/$imgName.png',
        width: 25,
        height: 25,
        fit: BoxFit.contain,
      ),
    ),
    title: (text == "设置" && !ifBadge)
        ? Badge(
            padding: EdgeInsets.all(3),
            position: BadgePosition(start: 34),
            child: Text(
              '$text',
              textAlign: TextAlign.left,
              style: AppStyles.textStyleBC,
            ),
          )
        : Text(
            '$text',
            textAlign: TextAlign.left,
            style: AppStyles.textStyleBC,
          ),
    trailing: Container(
      margin: EdgeInsets.only(right: 20),
      child: Icon(Icons.chevron_right),
    ),
    onTap: () {
      Navigator.pushNamed(context, routeName);
    },
  );
}
