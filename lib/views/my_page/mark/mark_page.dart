import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_mark.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

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
          ? loading()
          : animationList(
              context: context,
              dataList: dataList,
              childBuilder: oneFollow,
            ),
    );
  }
}

Widget oneFollow(BuildContext context, MarkData data) {
  return GestureDetector(
    onTap: () {
      var url = "https://www.yuque.com${data.sUrl}";
      openUrl(context, url);
    },
    child: Container(
      margin: EdgeInsets.only(top: 2, bottom: 9, left: 10, right: 10),
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            offset: Offset(1, 2),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(9.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              userAvatar(data.targetGroup.avatarUrl, height: 25),
              SizedBox(width: 6),
              Text(
                data.targetGroup.name,
                overflow: TextOverflow.clip,
                style: AppStyles.textStyleC,
              )
            ],
          ),
          SizedBox(height: 6),
          Text(
            data.title,
            style: AppStyles.textStyleB,
          ),
          SizedBox(height: 2),
          Text(
            data.target.description,
            style: AppStyles.textStyleC,
          )
        ],
      ),
    ),
  );
}
