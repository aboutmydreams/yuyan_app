import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';

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
          height: 12,
          color: AppColors.eventBack,
        ),
        oneColumn(context,
            imgName: "suggest", text: "意见与反馈", routeName: "/my/suggest"),
        oneColumn(context, imgName: "about", text: "关于语燕"),
        oneColumn(context,
            imgName: "setting", text: "设置", routeName: "/my/setting"),
      ],
    ),
  );
}

Widget oneColumn(BuildContext context,
    {String text, String imgName, String routeName}) {
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
    title: Text(
      '$text',
      textAlign: TextAlign.left,
      style: AppStyles.textStyleB,
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
