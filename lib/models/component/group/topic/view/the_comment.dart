import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/comments_data.dart';
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
            count == 0 ? "" : "评论 ($count)",
            style: AppStyles.textStyleB,
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
  print(data.user.avatarUrl);
  print(data.user.name);
  print("=================");
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        userAvatar(data.user.avatarUrl, height: 28),
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
              child: getHtml(
                context,
                data.bodyHtml,
                // padding: EdgeInsets.only(left: 37),
              ),
            )
          ],
        ),
      ],
    ),
  );
}
