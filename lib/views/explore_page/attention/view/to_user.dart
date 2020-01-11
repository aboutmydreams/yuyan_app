import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/tools/time_cut.dart';
import 'package:yuyan_app/models/widgets_small/user_event.dart';
import 'package:yuyan_app/state_manage/dataManage/data/attent_data.dart';

Widget toUser(BuildContext context, Data data) {
  print(data.avatarUrl);
  return Container(
    margin: EdgeInsets.only(top: 7),
    padding: EdgeInsets.only(top: 7, bottom: 7),
    decoration: BoxDecoration(
      color: AppColors.background,
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(128, 116, 116, 116),
          offset: Offset(0, 0),
          blurRadius: 1,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 18, right: 19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 46,
                margin: EdgeInsets.only(right: 3),
                child: userEvent(context,
                    login: data.login,
                    userImg: data.avatarUrl,
                    title: data.who,
                    event: "${data.did}",
                    time: timeCut(data.when)),
              ),
              Container(
                margin: EdgeInsets.only(top: 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.event.map((f) => oneEvent(f)).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget oneEvent(Event event) {
  return Container(
    height: 66,
    decoration: BoxDecoration(
      color: AppColors.eventBack,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        SizedBox(width: 27),
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
                image: event.avatarUrl,
                placeholder: 'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 7),
          child: Text(
            "${event.title}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryElement,
              fontFamily: "PingFang SC",
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
        Spacer(),
        Container(
          width: 27,
          height: 17,
          margin: EdgeInsets.only(right: 22),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 16,
                  margin: EdgeInsets.only(right: 3),
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.none,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 3),
                  child: Text(
                    "${event.count}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: "PingFang SC",
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
