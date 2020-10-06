import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/user/view/view/one_group.dart';
import 'package:yuyan_app/models/net/requests_api/search/data/group_data.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';

class SearchGroupPage extends StatelessWidget {
  const SearchGroupPage({Key key, this.searchGroupJson}) : super(key: key);

  final SearchGroupJson searchGroupJson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: searchGroupJson == null
          ? loading()
          : searchGroupJson.data.hits.isEmpty
              ? NothingPage(
                  top: 50,
                  text: "暂无用户~",
                )
              : animationList(
                  context: context,
                  aniWhich: 2,
                  dataList: searchGroupJson.data.hits
                      .map((data) => setData(data))
                      .toList(),
                  childBuilder: oneGroup,
                ),
    );
  }
}

GroupData setData(Hits data) {
  return GroupData(
    id: data.rRecord.id,
    avatarUrl: data.avatarUrl,
    login: data.login,
    description: data.description,
    name: data.name.replaceAll("<em>", "").replaceAll("</em>", ""),
  );
}
