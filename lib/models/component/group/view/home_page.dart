import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_home_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_home_data.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

class GroupHome extends StatefulWidget {
  GroupHome({Key key, this.homeJson}) : super(key: key);
  final GroupHomeJson homeJson;

  @override
  _GroupHomeState createState() => _GroupHomeState(homeJson: homeJson);
}

class _GroupHomeState extends State<GroupHome> {
  _GroupHomeState({Key key, this.homeJson});
  GroupHomeJson homeJson;

  @override
  Widget build(BuildContext context) {
    print(homeJson.data.bookStacks);
    return homeJson == null
        ? loading()
        : homeJson.data.bookStacks.isEmpty
            ? NothingPage()
            : SingleChildScrollView(
                child: aniColumn(
                  aniWhich: 4,
                  children: [SizedBox(height: 155)]
                    ..addAll(homeJson.data.bookStacks.map((a) {
                      return oneHome(context, a);
                    }).toList()),
                ),
              );
  }
}

Widget oneHome(BuildContext context, BookStacks data) {
  print(data.name);
  return GestureDetector(
    onTap: () {
      // openUrl(context, "https://www.yuque.com/${data.login}");
    },
    child: Container(
      height: 70,
      margin: EdgeInsets.only(left: 15, top: 2, bottom: 8, right: 15),
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
          // userAvatar(data.user.avatarUrl, height: 50),
          Container(
            margin: EdgeInsets.only(left: 6),
            child: iconType[data.displayType],
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.only(left: 20),
              child: Container(
                child: Text(
                  "${data.name}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textStyleB,
                ),
              )),

          // FollowButtom(data: data)
        ],
      ),
    ),
  );
}
