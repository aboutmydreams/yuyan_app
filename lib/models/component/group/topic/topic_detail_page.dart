import 'package:flutter/material.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/comments_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/one_topic/topic_comment_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/one_topic/topic_detail_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/group.dart';

class TopicDetail extends StatefulWidget {
  TopicDetail({Key key, this.groupId, this.iid, this.id}) : super(key: key);
  final int id;
  final int iid;
  final int groupId;

  @override
  _TopicDetailState createState() => _TopicDetailState();
}

class _TopicDetailState extends State<TopicDetail> {
  _TopicDetailState({Key key, this.groupId, this.iid, this.id});
  int groupId;
  int iid;
  int id;

  TopicDetailJson topicDetail;
  TopicCommentJson topicComments;

  getTopic() async {
    TopicDetailJson res = DioGroup.getOneTopicData(groupId: groupId, iid: iid);
    setState(() {
      topicDetail = res;
    });
  }

  getComment() async {
    TopicCommentJson res = await DioGroup.getComments(id);
    setState(() {
      topicComments = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("话题详情"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[Text("data")],
        ),
      ),
    );
  }
}
