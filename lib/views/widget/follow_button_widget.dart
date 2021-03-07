import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/controller/action_controller.dart';
import 'package:yuyan_app/model/document/user.dart';

class FollowButtonWidget extends StatefulWidget {
  final UserSeri user;
  final bool initialFollow;

  FollowButtonWidget({
    Key key,
    this.user,
    this.initialFollow,
  }) : super(key: key);

  @override
  _FollowButtonWidgetState createState() => _FollowButtonWidgetState();
}

class _FollowButtonWidgetState extends State<FollowButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 35,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.8),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: GetBuilder<FollowUserController>(
        tag: 'user: ${widget.user.id}',
        autoRemove: false,
        init: FollowUserController(
          userId: widget.user.id,
          isFollow: widget.initialFollow,
        ),
        builder: (c) {
          return FlatButton(
            onPressed: () async {
              c.toggle();
            },
            child: c.stageBuilder(
              onIdle: Center(
                child: Text(
                  "${(c.followed ?? false) ? '取消关注' : '关注'}",
                  style: TextStyle(color: Theme.of(context).canvasColor),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
