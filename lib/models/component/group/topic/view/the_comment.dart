import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/comments_data.dart';
import 'package:yuyan_app/models/tools/get_tag.dart';
import 'package:yuyan_app/models/tools/time_cut.dart';
import 'package:yuyan_app/models/widgets_big/html/body_html.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

class TheComment extends StatelessWidget {
  const TheComment({Key key, this.comment}) : super(key: key);
  final Comments comment;

  @override
  Widget build(BuildContext context) {
    int count = comment.data.length;
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            count == 0 ? "" : "评论",
            style: AppStyles.textStyleBp,
          ),
          SizedBox(height: 10),
        ]..addAll(comment.data.map((m) {
            return oneComment(context, m);
          }).toList()),
      ),
    );
  }
}

Widget oneComment(BuildContext context, CommentData data) {
  String tag = getTag();
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            OpenPage.user(
              context,
              tag: tag,
              login: data.user.login,
              name: data.user.name,
              avatarUrl: data.user.avatarUrl,
              userId: data.id,
            );
          },
          child: Hero(
            tag: tag,
            child: userAvatar(data.user.avatarUrl, height: 28),
          ),
        ),
        SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // padding: EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width - 70,
              child: Row(
                children: <Widget>[
                  Text(
                    data.user.name,
                    style: AppStyles.textStyleB,
                  ),
                  Spacer(),
                  Text(
                    timeCut(data.updatedAt),
                    style: AppStyles.textStyleCC,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 80,
              margin: EdgeInsets.only(top: 2, bottom: 16),
              child: getHtml(
                context,
                data.bodyHtml,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
