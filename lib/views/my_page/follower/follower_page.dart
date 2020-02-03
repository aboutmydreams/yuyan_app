import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/net/requests_api/requests_api.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_follow_data.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/tools/get_pref.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

class FollowerPage extends StatefulWidget {
  FollowerPage({Key key}) : super(key: key);

  @override
  _FollowerPageState createState() => _FollowerPageState();
}

class _FollowerPageState extends State<FollowerPage> {
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
        title: Text("关注我的"),
      ),
      body: dataList.isEmpty
          ? Text("loading")
          : animationList(
              context: context,
              dataList: dataList,
              childBuilder: oneFollow,
            ),

      // ListView.builder(
      //   controller: _controller,
      //   itemCount: dataList.length,
      //   itemBuilder: (context, index) {
      //     return oneFollow(context, dataList[index]);
      //   },
      // ),
    );
  }
}

Widget oneFollow(BuildContext context, FollowsData data) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: 70,
      margin: EdgeInsets.only(left: 5, top: 2, bottom: 8, right: 5),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 20),
          userAvatar(data.avatarUrl, height: 50),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: data.description != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          clearText(data.name, 10),
                          style: AppStyles.textStyleB,
                        ),
                      ),
                      Container(
                        child: Text(
                          "${clearText(data.description, 15)}",
                          style: AppStyles.textStyleC,
                        ),
                      ),
                    ],
                  )
                : Container(
                    child: Text(
                      clearText(data.name, 10),
                      style: AppStyles.textStyleB,
                    ),
                  ),
          ),
          Spacer(),
          FlatButton(
              onPressed: () {},
              child: Container(
                child: Text("关注"),
              ))
        ],
      ),
    ),
  );
}
