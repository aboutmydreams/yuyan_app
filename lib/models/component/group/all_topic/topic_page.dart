import 'package:flutter/material.dart';
import 'package:smart_color/smart_color.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_topic_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/group.dart';

import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

class AllTopicPage extends StatefulWidget {
  AllTopicPage({Key key, this.groupId, this.openTopicJson}) : super(key: key);
  final int groupId;
  final GroupTopicJson openTopicJson;

  @override
  _AllTopicPageState createState() =>
      _AllTopicPageState(groupId: groupId, openTopicJson: openTopicJson);
}

class _AllTopicPageState extends State<AllTopicPage> {
  _AllTopicPageState({Key key, this.groupId, this.openTopicJson});
  int groupId;
  GroupTopicJson openTopicJson;

  int offset = 0;
  int offset2 = 0;
  List<OneTopicData> closeList = [];

  @override
  void initState() {
    super.initState();
    getCloseData();
  }

  getCloseData() async {
    GroupTopicJson res =
        await DioGroup.getTopicData(groupId: groupId, state: "closed");
    setState(() {
      closeList = res.data;
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
              child: openTopicJson.data.isEmpty
                  ? loading()
                  : animationList(
                      context: context,
                      dataList: openTopicJson.data,
                      childBuilder: oneTopic,
                    ),
            ),
            Container(
              child: closeList.isEmpty
                  ? loading()
                  : animationList(
                      context: context,
                      dataList: closeList,
                      childBuilder: oneTopic,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget oneTopic(BuildContext context, OneTopicData data) {
  return GestureDetector(
    onTap: () {
      var url = "https://www.yuque.com/${data.group.login}/topics/${data.iid}";
      openUrl(context, url);
    },
    child: Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
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
              ]..addAll(data.labels != null ? data.labels.map(label) : []),
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
