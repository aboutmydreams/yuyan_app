import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/util/get_tag.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

Widget userEvent(BuildContext context,
    {String userImg,
    String login,
    int userId,
    String name,
    String event,
    String time,
    String tag}) {
  tag ??= getTag();
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {

        },
        child: Hero(tag: tag, child: userAvatar(userImg)),
      ),
      Expanded(
        flex: 1,
        child: Container(
          height: 44,
          margin: EdgeInsets.only(left: 14, bottom: 1),
          child: GestureDetector(
            onTap: () {
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$name",
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyleBB,
                ),
                SizedBox(height: 2),
                Text(
                  "$event",
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyleCC,
                )
              ],
            ),
          ),
        ),
      ),
      time == null
          ? Text("")
          : Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "$time",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "PingFang SC",
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ),
    ],
  );
}

Widget docUserEvent(BuildContext context,
    {String userImg,
    String login,
    int userId,
    String name,
    String event,
    String time,
    String tag}) {
  tag ??= getTag();
  return GestureDetector(
    onTap: () {
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        userAvatar(userImg),
        // child: Hero(tag: tag, child: userAvatar(userImg)),

        Expanded(
          flex: 1,
          child: Container(
            height: 44,
            margin: EdgeInsets.only(left: 14, bottom: 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$name",
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyleBB,
                ),
                SizedBox(height: 2),
                Text(
                  "$event",
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyleCC,
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
