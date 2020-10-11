import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/group/view/view/one_topic.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_topic_data.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';

class TopicPage extends StatelessWidget {
  TopicPage({Key key, this.topicJson, this.groupId}) : super(key: key);
  final GroupTopicJson topicJson;
  final int groupId;

  @override
  Widget build(BuildContext context) {
    return topicJson == null
        ? loading()
        : topicJson.data.isEmpty
            ? NothingPage(
                top: 190,
                text: "暂无讨论",
              )
            : SingleChildScrollView(
                child: aniColumn(
                    aniWhich: 4,
                    children: [SizedBox(height: 155)]..addAll(
                        topicJson.data.map((a) {
                          return oneTopic(context, a);
                        }).toList(),
                      )),
              );
  }
}
