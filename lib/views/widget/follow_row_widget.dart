import 'package:flutter/material.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/follow_button_widget.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class FollowRowItemWidget extends StatelessWidget {
  final UserSeri user;
  final bool isFollow;

  const FollowRowItemWidget({
    Key key,
    this.user,
    this.isFollow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // user.isfollow = true;
    String tag = Util.genHeroTag();
    return GestureDetector(
      onTap: () {
        // OpenPage.user(
        //   context,
        //   login: data.login,
        //   tag: tag,
        //   name: data.name,
        //   avatarUrl: data.avatarUrl,
        //   userId: data.id,
        // );
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
