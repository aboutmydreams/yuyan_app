import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/controller/global/user_controller.dart';
import 'package:yuyan_app/views/user_page/user_page.dart';

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

  const LakeMentionWidget({
    Key key,
    this.name,
    this.login,
    this.showLogin = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = '@$name';
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
        ),
      ),
    );
  }
}
