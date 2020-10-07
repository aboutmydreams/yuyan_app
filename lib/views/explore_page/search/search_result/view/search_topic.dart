import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/group/view/view/one_topic.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_topic_data.dart';
import 'package:yuyan_app/models/net/requests_api/search/data/topic_data.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';

class SearchTopicPage extends StatelessWidget {
  const SearchTopicPage({Key key, this.searchTopicJson}) : super(key: key);

  final SearchTopicJson searchTopicJson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: searchTopicJson == null
          ? loading()
          : searchTopicJson.data.hits.isEmpty
              ? NothingPage(
                  top: 50,
                  text: "暂无用户~",
                )
              : animationList(
                  context: context,
                  aniWhich: 2,
                  dataList: searchTopicJson.data.hits
                      .map((data) => setData(data))
                      .toList(),
                  childBuilder: oneTopic,
                ),
    );
  }
}

OneTopicData setData(Hits data) {
  return OneTopicData(
    id: data.rRecord.id,
    iid: data.rRecord.iid,
    commentsCount: data.rRecord.commentsCount,
    title: data.title,
    updatedAt: data.rRecord.updatedAt,
    createdAt: data.rRecord.createdAt,
    user: User(
      name: data.rRecord.group.name,
      avatarUrl: data.rRecord.group.avatarUrl,
    ),
  );
}
