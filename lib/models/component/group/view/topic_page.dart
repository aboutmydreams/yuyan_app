import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_member_data.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

class TopicPage extends StatefulWidget {
  TopicPage({Key key, this.memberJson}) : super(key: key);
  final MemberJson memberJson;

  @override
  _TopicPageState createState() => _TopicPageState(memberJson: memberJson);
}

class _TopicPageState extends State<TopicPage> {
  _TopicPageState({Key key, this.memberJson});
  final MemberJson memberJson;

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 100.0, //item高度或宽度，取决于滑动方向
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return oneFollow(context, memberJson.data[index]);
        },
        childCount: memberJson.data.length,
      ),
    );
  }
}

Widget oneFollow(BuildContext context, MemberData data) {
  return GestureDetector(
    onTap: () {
      // openUrl(context, "https://www.yuque.com/${data.login}");
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 20),
          userAvatar(data.user.avatarUrl, height: 50),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            margin: EdgeInsets.only(left: 20),
            child: data.user.description != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          clearText(data.user.name, 10),
                          style: AppStyles.textStyleB,
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        child: Text(
                          "${clearText(data.user.description, 15)}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textStyleC,
                        ),
                      ),
                    ],
                  )
                : Container(
                    child: Text(
                      "${data.user.name}",
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
