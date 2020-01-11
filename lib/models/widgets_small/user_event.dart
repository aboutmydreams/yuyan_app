import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

Widget userEvent(BuildContext context,
    {String userImg, String login, String title, String event, String time}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          openUrl(context, "https://www.yuque.com/$login");
        },
        child: userAvatar(userImg),
      ),
      Expanded(
        flex: 1,
        child: Container(
          height: 46,
          margin: EdgeInsets.only(left: 14, bottom: 1),
          child: GestureDetector(
            onTap: () {
              openUrl(context, "https://www.yuque.com/$login");
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "PingFang SC",
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "$event",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black45,
                    fontFamily: "PingFang SC",
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
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
