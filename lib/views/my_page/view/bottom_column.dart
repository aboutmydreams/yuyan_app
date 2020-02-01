import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';

Widget threeWidget(BuildContext context) {
  return Container(
    child: Column(
      children: <Widget>[
        oneColumn(context, imgName: "collections", text: "我的收藏"),
        oneColumn(context, imgName: "follow_book", text: "关注知识库"),
        oneColumn(context, imgName: "topics", text: "我的讨论"),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 20,
          color: AppColors.eventBack,
        ),
        oneColumn(context, imgName: "collections", text: "意见与反馈"),
        oneColumn(context, imgName: "collections", text: "关于语燕"),
        oneColumn(context,
            imgName: "follow_book", text: "设置", routeName: "/my/setting"),
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
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      ),
    ),
    title: Text(
      '$text',
      textAlign: TextAlign.left,
      style: AppStyles.textStyleB,
    ),
    trailing: Container(
      margin: EdgeInsets.only(right: 24),
      child: Icon(Icons.chevron_right),
    ),
    onTap: () {
      Navigator.pushNamed(context, routeName);
    },
  );
}
