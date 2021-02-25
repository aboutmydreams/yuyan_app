import 'package:flutter/material.dart';
import 'package:smart_color/smart_color.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/my_topic_data.dart';
import 'package:yuyan_app/models/tools/analytics.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

class TopicPage extends StatefulWidget {
  TopicPage({Key key}) : super(key: key);

  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  int offset = 0;
  int offset2 = 0;
  List<TopicData> dataList;
  List<TopicData> dataList2;
  // ScrollController _controller;

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
    analytics.logEvent(name: 'my_topic');
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
              child: dataList == null
                  ? loading()
                  : dataList.isEmpty
                      ? NothingPage(
                          top: 50,
                          text: "没有正在进行的话题~",
                        )
                      : animationList(
                          context: context,
                          dataList: dataList,
                          childBuilder: oneTopic,
                        ),
            ),
            Container(
              child: dataList2 == null
                  ? loading()
                  : dataList2.isEmpty
                      ? NothingPage(
                          top: 50,
                          text: "没有已关闭的话题~",
                        )
                      : animationList(
                          context: context,
                          dataList: dataList2,
                          childBuilder: oneTopic,
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget oneTopic(BuildContext context, TopicData data) {
  data.labels ??= [];

  return GestureDetector(
    onTap: () {
      // var url = "https://www.yuque.com/${data.group.login}/topics/${data.iid}";
      // openUrl(context, url);
      OpenPage.topic(
        context,
        id: data.id,
        iid: data.iid,
        groupId: data.groupId,
      );
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
              userAvatar(data.user.avatarUrl, height: 25),
              SizedBox(width: 8),
              Text(
                data.user.name,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.textStyleC,
              )
            ],
          ),
          SizedBox(height: 6),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: data.title + "  ",
                  style: AppStyles.textStyleB,
                ),
              ]..addAll(data.labels.map(label)),
            ),
          ),
          SizedBox(height: 2),
        ],
      ),
    ),
  );
}

TextSpan label(Labels label) {
  return TextSpan(
    text: label.name,
    style: TextStyle(
      backgroundColor: SmartColor.parse(label.color),
    ),
  );
}
