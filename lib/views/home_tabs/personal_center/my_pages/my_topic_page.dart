import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/controller/global/my_controller.dart';
import 'package:yuyan_app/views/organization/topic_page/topic_item_widget.dart';
import 'package:yuyan_app/views/widget/animation.dart';
import 'package:yuyan_app/views/component/nothing_page.dart';

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
              return TopicRowItemWidget(data: data[i]);
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
