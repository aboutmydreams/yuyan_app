import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/controller/organization/group/group_controller.dart';
import 'package:yuyan_app/controller/organization/user/user_controller.dart';
import 'package:yuyan_app/model/user/group/group.dart';
import 'package:yuyan_app/views/organization/group_page/group_page.dart';
import 'package:yuyan_app/views/organization/user_page/user_page.dart';

class GroupById extends StatelessWidget {
  final int groupId;
  final int index;

  const GroupById({
    Key key,
    this.groupId,
    this.index = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupInfoController>(
      init: GroupInfoController(groupId),
      tag: '$groupId',
      builder: (c) => c.pageBuilder(
        parent: (child) => Scaffold(
          appBar: AppBar(
            title: Text('@Group($groupId)'),
          ),
          body: child,
        ),
        onIdle: () => GroupPage(
          initialIndex: index,
          group: GroupSeri.fromJson(
            c.value.toJson(),
          ),
        ),
      ),
    );
  }
}

class UserByLoginPage extends StatelessWidget {
  final String login;

  const UserByLoginPage({
    Key key,
    this.login,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("@$login"),
      ),
      body: GetBuilder<UserInfoController>(
        init: UserInfoController(login: login),
        tag: '$login',
        builder: (c) => c.stateBuilder(
          onIdle: () {
            Future.delayed(Duration(milliseconds: 10), () {
              Get.off(
                UserPage(user: c.value.toUserLite()),
                transition: Transition.noTransition,
              );
            });
            return Container();
          },
        ),
      ),
    );
  }
}

class LakeMentionWidget extends StatelessWidget {
  final String name;
  final String login;
  final bool showLogin;
  final String before;
  final double fontSize;

  const LakeMentionWidget({
    Key key,
    this.name,
    this.login,
    this.fontSize = 12,
    this.showLogin = true,
    this.before = '@',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = '$before$name';
    if (showLogin) {
      text += '($login)';
    }
    return GestureDetector(
      onTap: () {
        MyRoute.userByLogin(login);
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
