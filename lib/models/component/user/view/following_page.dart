import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/component/user/view/view/one_user.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_follow_data.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/tools/get_tag.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

class FollowingPage extends StatelessWidget {
  FollowingPage({Key key, this.followingJson}) : super(key: key);
  final Follows followingJson;

  @override
  Widget build(BuildContext context) {
    return followingJson == null
        ? loading()
        : followingJson.data.isEmpty
            ? NothingPage(text: "暂无关注", top: 180)
            : SingleChildScrollView(
                child: aniColumn(
                  aniWhich: 4,
                  children: [SizedBox(height: 155)]..addAll(
                      followingJson.data.map((a) {
                        return oneUser(context, setFollowingData(a));
                      }).toList(),
                    ),
                ),
              );
  }
}

Map<String, dynamic> setFollowingData(FollowsData data) {
  String tag = getTag();
  return {
    "tag": tag,
    "login": data.login,
    "name": data.name,
    "avatarUrl": data.avatarUrl,
    "userId": data.id,
    "description": data.description,
  };
}
