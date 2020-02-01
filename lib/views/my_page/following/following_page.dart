import 'package:flutter/material.dart';
import 'package:yuyan_app/models/net/requests_api/requests_api.dart';
import 'package:yuyan_app/models/tools/get_pref.dart';
import 'package:yuyan_app/views/my_page/data/follow.dart';

class FollowingPage extends StatefulWidget {
  FollowingPage({Key key}) : super(key: key);

  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  int offset = 0;
  List<FollowsData> dataList = [];
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    getFollowerData();
  }

  getFollowerData() async {
    var myId = await getPrefIntData("my_id");
    var res = await DioReq.get(
        "/actions/users?action_type=follow&offset=$offset&target_id=$myId&target_type=User");
    Follows theData = Follows.fromJson(res);
    setState(() {
      dataList = theData.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我关注的"),
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return oneFollow(context, dataList[index]);
        },
      ),
    );
  }
}

Widget oneFollow(BuildContext context, FollowsData data) {
  return Text("${data.name}");
}
