import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/user/view/view/one_user.dart';
import 'package:yuyan_app/models/net/requests_api/search/data/user_data.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';

class SearchUserPage extends StatelessWidget {
  const SearchUserPage({Key key, this.searchUserJson}) : super(key: key);

  final SearchUserJson searchUserJson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: searchUserJson == null
          ? loading()
          : searchUserJson.data.hits.isEmpty
              ? NothingPage(
                  top: 50,
                  text: "暂无用户~",
                )
              : animationList(
                  context: context,
                  aniWhich: 2,
                  dataList: searchUserJson.data.hits
                      .map((data) => setData(data))
                      .toList(),
                  childBuilder: oneUser,
                ),
    );
  }
}

Map<String, dynamic> setData(Hits data) {
  return {
    "login": data.login,
    "userId": data.rRecord.id,
    "avatarUrl": data.avatarUrl,
    "description": data.description,
    "name": data.name.replaceAll("</em>", "").replaceAll("<em>", ""),
  };
}
