import 'package:flutter/material.dart';
import 'package:yuyan_app/model/events/user_lite_seri.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class UserFlexibleWidget extends StatelessWidget {
  final UserLiteSeri user;
  final String tag;

  const UserFlexibleWidget({
    Key key,
    this.user,
    this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heroTag = tag ?? '${user.id}';
    return Stack(
      children: <Widget>[
        Positioned(
          child: Container(
            // height: 230,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/first.jpg",
              color: Colors.black45,
              colorBlendMode: BlendMode.darken,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 72,
          top: 125,
          right: 38,
          child: Row(
            children: [
              Container(
                width: 170,
                child: Text(
                  "${user.description ?? '这人很懒，签名也没有'}",
                  style: AppStyles.groupTextStyle,
                  maxLines: 4,
                ),
              ),
              Spacer(),
              Hero(
                tag: heroTag,
                child: UserAvatarWidget(
                  avatar: user.avatarUrl,
                  height: 60,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
