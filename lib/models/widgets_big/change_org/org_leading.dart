import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/widgets_small/show_dialog/show_dialog.dart';
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
    return (organizations != null) && (organizations.length > 0)
        ? ScopedModelDescendant<MyInfoManage>(builder: (context, child, model) {
            // 默认拥有一个个人工作台
            List<Organiz> useOrg = [
              Organiz(
                host: "",
                name: model.myInfoData.data.name,
                logo: model.myInfoData.data.avatarUrl,
                login: "",
                sSerializer: "",
              )
            ];
            useOrg.addAll(organizations);
            return InkWell(
              child: IconButton(
                icon: userAvatar(model.nowOrgImg),
                tooltip: '切换',
                onPressed: () {
                  // 构建弹窗内的子元素列表
                  List lite(BuildContext context, List<Organiz> data) {
                    return data.map((o) => OneLite(org: o)).toList();
                  }

                  // 切换工作台弹窗
                  showWindow(
                    context,
                    title: "切换工作台",
                    children: lite(context, useOrg),
                  );
                },
              ),
            );
          })
        : Container();
  }
}

class OneLite extends StatelessWidget {
  const OneLite({Key key, this.org}) : super(key: key);
  final Organiz org;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: userAvatar(org.logo),
      title: Text(org.name),
      onTap: () async {
        String nowOrg = await topModel.myInfoManage.getMyNowOrg();
        if (org.login == nowOrg) {
          Timer(Duration(milliseconds: 300), () {
            myToast(context, "😂");
            Navigator.pop(context);
          });
        } else {
          await topModel.myInfoManage.changeOrg(org);
          await topModel.update();

          Timer(Duration(milliseconds: 300), () {
            myToast(context, "切换成功");
            Navigator.pop(context);
          });
        }
      },
    );
  }
}
