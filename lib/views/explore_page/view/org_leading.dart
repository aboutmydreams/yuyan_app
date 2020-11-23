import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/widgets_small/show_dialog.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/organiz_data.dart';
import 'package:yuyan_app/state_manage/dataManage/mydata_manage.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

/// 切换空间组件
/// 先获取用户空间 List
/// 如果原始空间 List 为空，那么就不显示这个组件
/// 如果原始空间 List 不为空，初始化时在 List 中插入一个个人工作区
/// 用户点击该组件时弹窗选择空间
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
    return organizations.length > 0
        ? InkWell(
            child: IconButton(
              icon: ScopedModelDescendant<MyInfoManage>(
                  builder: (context, child, model) {
                return userAvatar(model.nowOrgImg);
              }),
              tooltip: '切换',
              onPressed: () {
                List lite(BuildContext context, List<Organiz> data) {
                  return data
                      .map((o) => ListTile(
                            leading: userAvatar(o.logo),
                            title: Text(o.name),
                            onTap: () async {
                              await topModel.myInfoManage.changeOrg(o);
                              await topModel.update();

                              Timer(Duration(milliseconds: 300), () {
                                myToast(context, "切换成功");
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/', (route) => route == null);
                              });
                            },
                          ))
                      .toList();
                }

                showWindow(context,
                    title: "切换工作台", children: lite(context, useOrg));
              },
            ),
          )
        : Container();
  }
}
