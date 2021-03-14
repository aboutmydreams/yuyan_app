import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/app.dart';
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
    var isSelf = App.user.data.id == widget.user.id;
    return Container(
      width: 88,
      height: 35,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.8),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: isSelf
          ? FlatButton(
              onPressed: () async {
                BotToast.showText(text: '想要关注自己吗?');
              },
              child: Center(
                child: Text(
                  "你",
                  style: TextStyle(color: Theme.of(context).canvasColor),
                ),
              ),
            )
          : GetBuilder<FollowUserController>(
              tag: '${widget.user.id}',
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
                  child: c.stateBuilder(
                    onIdle: () => Center(
                      child: Text(
                        "${(c.value ?? false) ? '取消关注' : '关注'}",
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
