import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/user/user.dart';
import 'package:yuyan_app/model/user/user_lite_seri.dart';
import 'package:yuyan_app/util/styles/app_ui.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/image.dart';

import 'follow.dart';

class UserMemberIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MyRoute.webview('https://www.yuque.com/settings/member');
      },
      child: Container(
        width: 21,
        height: 23,
        margin: EdgeInsets.only(left: 13),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(20, 0, 0, 0),
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Image.asset(
          "assets/images/my_page/member.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class UserTileWidget extends StatelessWidget {
  final UserLiteSeri user;

  const UserTileWidget({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heroTag = Util.genHeroTag();
    Widget child = Container(
      height: 70,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            offset: Offset(1, 1),
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: 16),
          Hero(
            tag: heroTag,
            child: UserAvatarWidget(
              avatar: user.avatarUrl,
              height: 50,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            margin: EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    user.name.clip(10, ellipsis: true),
                    style: AppStyles.textStyleB,
                  ),
                ),
                SizedBox(height: 2),
                if (user.description != null)
                  Container(
                    child: Text(
                      user.description.clip(15, ellipsis: true),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.textStyleC,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
    return GestureDetector(
      onTap: () {
        MyRoute.user(
          user: user,
          heroTag: heroTag,
        );
      },
      child: child,
    );
  }
}

class UserFollowTileWidget extends StatelessWidget {
  final UserSeri user;
  final bool isFollow;
  final bool hideButton;

  const UserFollowTileWidget({
    Key key,
    this.user,
    this.isFollow,
    this.hideButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // user.isfollow = true;
    // String tag = Util.genHeroTag();
    return GestureDetector(
      onTap: () {
        MyRoute.user(user: user.toUserLiteSeri());
      },
      child: Container(
        height: 70,
        margin: EdgeInsets.only(left: 5, top: 2, bottom: 8, right: 5),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0),
              offset: Offset(1, 2),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 20),
            UserAvatarWidget(avatar: user.avatarUrl, height: 50),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      user.name.clip(10, ellipsis: true),
                      style: AppStyles.textStyleB,
                    ),
                  ),
                  SizedBox(height: 2),
                  if (user.description != null)
                    Container(
                      child: Text(
                        user.description.clip(15, ellipsis: true),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.textStyleC,
                      ),
                    ),
                ],
              ),
            ),
            Spacer(),
            if (!hideButton)
              FollowButtonWidget(
                user: user,
                initialFollow: isFollow,
              ),
          ],
        ),
      ),
    );
  }
}

class UserActionTileWidget extends StatelessWidget {
  final UserLiteSeri user;
  final String title;
  final String subTitle;
  final String actionTime;

  UserActionTileWidget({
    Key key,
    this.user,
    this.title,
    this.subTitle,
    this.actionTime,
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
        if (!GetUtils.isNullOrBlank(actionTime))
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              Util.timeCut("$actionTime"),
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
          user: user,
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
        child: SmartImageWidget(
          url: imgUrl,
          circular: true,
        ),
      ),
    );
  }
}
