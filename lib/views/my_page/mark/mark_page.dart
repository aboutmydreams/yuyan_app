import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:yuyan_app/models/net/requests_api/requests_api.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/views/my_page/data/follow.dart';
import 'package:yuyan_app/views/my_page/data/mark.dart';

class MarkPage extends StatefulWidget {
  MarkPage({Key key}) : super(key: key);

  @override
  _MarkPageState createState() => _MarkPageState();
}

class _MarkPageState extends State<MarkPage> {
  int offset = 0;
  List<MarkData> dataList = [];
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    getFollowerData();
  }

  getFollowerData() async {
    var res = await DioReq.get("/mine/marks?limit=200&offset=$offset&type=all");
    MarkJson theData = MarkJson.fromJson(res);
    setState(() {
      dataList = theData.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的收藏"),
      ),
      body: dataList.isEmpty
          ? Text("loading")
          : animationList(
              context: context, dataList: dataList, childBuilder: oneFollow),
    );
  }
}

Widget oneFollow(BuildContext context, MarkData data) {
  return Text("${data.title}");
}
