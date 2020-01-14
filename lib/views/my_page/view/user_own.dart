import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';

Widget infoOwn() {
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      width: 289,
      height: 52,
      margin: EdgeInsets.only(top: 28),
      child: Row(
        children: [
          oneOwn("关注", "follow_book"),
          Spacer(),
          oneOwn("收藏", "collections"),
          Spacer(),
          oneOwn("讨论", "topics"),
          Spacer(),
          oneOwn("浏览", "history"),
        ],
      ),
    ),
  );
}

Widget oneOwn(String text, String imgName) {
  return Container(
    width: 45,
    height: 52,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 22,
            width: 23,
            child: Image.asset(
              'assets/images/my_page/$imgName.png',
              fit: BoxFit.contain,
            )),
        Spacer(),
        Text(
          "$text",
          textAlign: TextAlign.center,
          style: AppStyles.textStyleBB,
        ),
      ],
    ),
  );
}
