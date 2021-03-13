import 'package:flutter/material.dart';

class LakeMentionWidget extends StatelessWidget {
  final String name;
  final String login;

  const LakeMentionWidget({
    Key key,
    this.name,
    this.login,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO add open user page by login
        // MyRoute.user(user: null);
      },
      child: Text(
        '@$name($login)',
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
    );
  }
}
