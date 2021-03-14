import 'package:flutter/material.dart';

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
        //TODO add open user page by login
        // MyRoute.user(user: null);
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
