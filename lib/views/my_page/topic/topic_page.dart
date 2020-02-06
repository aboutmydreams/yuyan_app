import 'package:flutter/material.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';

import 'package:yuyan_app/models/net/requests_api/user/data/user_topic_data.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';

class TopicPage extends StatefulWidget {
  TopicPage({Key key}) : super(key: key);

  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  int offset = 0;
  int offset2 = 0;
  List<TopicData> dataList = [];
  List<TopicData> dataList2 = [];
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    getFollowerData();
  }

  getFollowerData() async {
    var res = await DioReq.get(
        "/mine/topics?limit=200&offset=$offset&state=open&type=participated");
    var res2 = await DioReq.get(
        "/mine/topics?limit=200&offset=$offset2&state=closed&type=participated");
    TopicJson theData = TopicJson.fromJson(res);
    TopicJson theData2 = TopicJson.fromJson(res2);
    setState(() {
      dataList = theData.data;
      dataList2 = theData2.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3.0,
            indicatorColor: Colors.white70,
            tabs: <Widget>[
              Tab(
                text: "进行中",
              ),
              Tab(
                text: "已关闭",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              child: dataList.isEmpty
                  ? loading()
                  : animationList(
                      context: context,
                      dataList: dataList,
                      childBuilder: oneFollow,
                    ),
            ),
            Container(
              child: dataList2.isEmpty
                  ? loading()
                  : animationList(
                      context: context,
                      dataList: dataList2,
                      childBuilder: oneFollow,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget oneFollow(BuildContext context, TopicData data) {
  return Text("${data.title}");
}
