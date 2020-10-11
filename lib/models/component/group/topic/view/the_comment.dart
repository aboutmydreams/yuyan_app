import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/comments_data.dart';
import 'package:yuyan_app/models/tools/get_tag.dart';
import 'package:yuyan_app/models/tools/time_cut.dart';
import 'package:yuyan_app/models/widgets_big/html/body_html.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

class TheComment extends StatelessWidget {
  const TheComment({Key key, this.comment}) : super(key: key);
  final Comments comment;

  @override
  Widget build(BuildContext context) {
    int count = comment.data.length;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16, top: 20, bottom: 2),
          child: Text(
            count == 0 ? "" : "评论",
            style: AppStyles.textStyleBBB,
          ),
        ),
        SizedBox(height: 10),
      ]
        ..addAll(comment.data.map((m) {
          return oneComment(context, m);
        }).toList())
        ..add(Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                myToast(context, "加入讨论呗");
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 100, 45),
                child: Text(
                  count > 5 ? "👉" : "",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ))),
    );
  }
}

Widget oneComment(BuildContext context, CommentData data) {
  String tag = getTag();
  return Container(
    margin: EdgeInsets.only(bottom: 1),
    padding: EdgeInsets.only(left: 15, top: 32, bottom: 20, right: 15),
    decoration: BoxDecoration(
      color: AppColors.background,
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(20, 0, 0, 0),
          offset: Offset(1, 1),
          blurRadius: 2,
        ),
      ],
    ),
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // padding: EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width - 90,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        data.user.name,
                        style: AppStyles.textStyleB,
                      ),
                    ),
                    Text(
                      timeCut(data.updatedAt),
                      style: AppStyles.textStyleCC,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              getHtml(
                context,
                data.bodyHtml,
              ),
            ],
          ),
        )
      ],
    ),
  );
}
