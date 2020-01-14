import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/models/widgets_small/user_event.dart';
import 'package:yuyan_app/state_manage/dataManage/data/news_data.dart';

Widget oneNew(BuildContext context, Notifications data) {
  return Container(
      height: 170,
      width: MediaQuery.of(context).size.width,
      color: AppColors.background,
      child: Row(
        children: <Widget>[
          userAvatar(data.actor.avatarUrl),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${data.actor.name}",
                      style: AppStyles.textStyleB,
                    ),
                    Container(
                      width: 40,
                      child: Text("data"),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${data.actor.name}",
                      style: AppStyles.textStyleC,
                    ),
                    Container(
                      width: 40,
                      child: Text("data"),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      )
      // Column(
      //   children: <Widget>[
      //     userEvent(context,
      //         userImg: data.actor.avatarUrl,
      //         login: data.actor.login,
      //         event: data.notifyType,
      //         time: data.createdAt)
      //   ],
      // ),
      );
}
