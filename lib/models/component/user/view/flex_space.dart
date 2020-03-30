import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

Widget userFlexSpace(BuildContext context,
    {String description, int userId, String avatarUrl, String tag}) {
  tag ??= userId.toString();
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
                "${description ?? '这人很懒，签名也没有'}",
                style: AppStyles.groupTextStyle,
                maxLines: 4,
              ),
            ),
            Spacer(),
            Hero(
              tag: tag,
              child: userAvatar(avatarUrl, height: 60),
            ),
          ],
        ),
      ),
    ],
  );
}
