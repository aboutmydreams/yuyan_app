import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/util/util.dart';

class UserTileWidget extends StatelessWidget {
  final UserSeri user;
  final String title;
  final String subTitle;
  final String time;

  UserTileWidget({
    Key key,
    this.user,
    this.title,
    this.subTitle,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tag = Util.genHeroTag();
    var child = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Hero(tag: tag, child: UserAvatarWidget(avatar: user.avatarUrl)),
        Expanded(
          flex: 1,
          child: Container(
            height: 44,
            margin: EdgeInsets.only(left: 14, bottom: 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${title ?? user.name}",
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyleBB,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 2),
                Text(
                  "${subTitle ?? user.description}",
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyleCC,
                )
              ],
            ),
          ),
        ),
        if (!GetUtils.isNullOrBlank(time))
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              Util.timeCut("$time"),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "PingFang SC",
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
    return GestureDetector(
      onTap: () {
        MyRoute.user(
          user: user.toUserLiteSeri(),
          heroTag: tag,
        );
      },
      child: child,
    );
  }
}

class UserAvatarWidget extends StatelessWidget {
  final String avatar;
  final double height;

  const UserAvatarWidget({
    Key key,
    this.avatar =
        "https://cdn.nlark.com/yuque/0/2019/png/84147/1547032500238-d93512f4-db23-442f-b4d8-1d46304f9673.png",
    this.height = 34,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (avatar == null) {
      return SizedBox.shrink();
    }
    var imgUrl = Util.ossImg(avatar);

    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2 + 3),
      child: Container(
        width: height,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(128, 116, 116, 116),
              offset: Offset(0, 0),
              blurRadius: 1,
            ),
          ],
        ),
        child: ClipOval(
          child: imgUrl.contains("assets/")
              ? Image.asset(imgUrl)
              : CachedNetworkImage(
                  imageUrl: imgUrl,
                  placeholder: (context, url) => FlareActor(
                    "assets/flares/progress.flr",
                    animation: "active",
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
