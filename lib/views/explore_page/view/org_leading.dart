import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yuyan_app/models/widgets_small/show_dialog.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/organiz_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

class OrgLeading extends StatefulWidget {
  OrgLeading({Key key}) : super(key: key);

  @override
  _OrgLeadingState createState() => _OrgLeadingState();
}

class _OrgLeadingState extends State<OrgLeading> {
  List<Organiz> organizations = topModel.myInfoManage.organizData.data;

  @override
  Widget build(BuildContext context) {
    List<Organiz> useOrg = [
      Organiz(
        host: "",
        name: topModel.myInfoManage.myInfoData.data.name,
        logo: topModel.myInfoManage.myInfoData.data.avatarUrl,
        login: "",
        sSerializer: "",
      )
    ];
    useOrg.addAll(organizations);
    return InkWell(
      child: IconButton(
        icon: userAvatar(topModel.myInfoManage.nowOrgImg),
        tooltip: '切换',
        onPressed: () {
          List lite(BuildContext context, List<Organiz> data) {
            print(topModel.myInfoManage.nowOrgImg);
            return data
                .map((o) => ListTile(
                      leading: userAvatar(o.logo),
                      title: Text(o.name),
                      onTap: () async {
                        await topModel.myInfoManage.changeOrg(o);

                        await topModel.update();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (route) => route == null);
                        Timer(Duration(seconds: 1), () {
                          myToast(context, "切换成功");
                        });
                      },
                    ))
                .toList();
          }

          showWindow(context, title: "切换工作台", children: lite(context, useOrg));
        },
      ),
    );
  }
}
