import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_color/smart_color.dart';
import 'package:yuyan_app/controller/global/user_controller.dart';
import 'package:yuyan_app/model/topic/labels.dart';
import 'package:yuyan_app/model/topic/topic.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/views/widget/animation_widget.dart';

class MyTopicPage extends StatelessWidget {
  Widget buildTab(String state) {
    return GetBuilder<MyTopicController>(
      tag: state,
      autoRemove: false,
      init: MyTopicController(topicState: state),
      builder: (c) => c.builder(
        (state) {
          var data = state.data;
          return AnimationListWidget(
            itemCount: data.length,
            itemBuilder: (_, i) {
              return MyTopicItemWidget(data: data[i]);
            },
          );
        },
        onEmpty: NothingPage(
          top: 50,
          text: "没有正在进行的话题~",
        ),
      ),
    );
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
              Tab(text: "进行中"),
              Tab(text: "已关闭"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            buildTab('open'),
            buildTab('closed'),
          ],
        ),
      ),
    );
  }
}

class MyTopicItemWidget extends StatelessWidget {
  final TopicSeri data;

  const MyTopicItemWidget({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    data.labels ??= [];

    return GestureDetector(
      onTap: () {
        // var url = "https://www.yuque.com/${data.group.login}/topics/${data.iid}";
        // openUrl(context, url);
        // OpenPage.topic(
        //   context,
        //   id: data.id,
        //   iid: data.iid,
        //   groupId: data.groupId,
        // );
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

  TextSpan label(LabelSeri label) {
    return TextSpan(
      text: label.name,
      style: TextStyle(
        backgroundColor: SmartColor.parse(
          label.color,
        ),
      ),
    );
  }
}
