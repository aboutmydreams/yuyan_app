import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_member_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_follow_data.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

class FollowerPage extends StatefulWidget {
  FollowerPage({Key key, this.followerJson}) : super(key: key);
  final Follows followerJson;

  @override
  _FollowerPageState createState() =>
      _FollowerPageState(followerJson: followerJson);
}

class _FollowerPageState extends State<FollowerPage> {
  _FollowerPageState({Key key, this.followerJson});
  Follows followerJson;

  @override
  Widget build(BuildContext context) {
    return followerJson == null
        ? loading()
        : followerJson.data.isEmpty
            ? NothingPage(text: "暂无关注", top: 180)
            : SingleChildScrollView(
                child: aniColumn(
                    aniWhich: 4,
                    children: [SizedBox(height: 155)]..addAll(
                        followerJson.data.map((a) {
                          return oneFollower(context, a);
                        }).toList(),
                      )),
              );
  }
}

Widget oneFollower(BuildContext context, FollowsData data) {
  return GestureDetector(
    onTap: () {
      OpenPage.user(
        context,
        login: data.login,
        name: data.name,
        avatarUrl: data.avatarUrl,
        userId: data.id,
      );
    },
    child: Container(
      height: 70,
      margin: EdgeInsets.only(left: 15, top: 10, right: 15),
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 20),
          userAvatar(data.avatarUrl, height: 50),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            margin: EdgeInsets.only(left: 20),
            child: data.description != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          clearText(data.name, 10),
                          style: AppStyles.textStyleB,
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        child: Text(
                          "${clearText(data.description, 15)}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textStyleC,
                        ),
                      ),
                    ],
                  )
                : Container(
                    child: Text(
                      "${data.name}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.textStyleB,
                    ),
                  ),
          ),
          Spacer(),
          // FollowButtom(data: data)
        ],
      ),
    ),
  );
}
