import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';

Widget userEvent({String userImg, String title, String event, String time}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(128, 116, 116, 116),
                offset: Offset(0, 0),
                blurRadius: 1,
              ),
            ],
          ),
          child: ClipOval(
            child: FadeInImage.assetNetwork(
              image: userImg,
              placeholder: 'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Container(
          height: 46,
          margin: EdgeInsets.only(left: 14, bottom: 1),
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
