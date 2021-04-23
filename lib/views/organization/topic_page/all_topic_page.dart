import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuyan_app/controller/global/group_controller.dart';

import 'topic_add_page.dart';
import 'topic_item_widget.dart';

class GroupTopicAllPage extends StatelessWidget {
  final int groupId;

  GroupTopicAllPage({
    Key key,
    @required this.groupId,
  }) : super(key: key);

  String get tag => '$groupId';

  Widget buildTab(String state) {
    return GetBuilder<GroupTopicController>(
      tag: tag + '$state',
      init: GroupTopicController(groupId, state),
      builder: (c) => c.stateBuilder(
        onIdle: () => SmartRefresher(
          controller: c.refreshController,
          onRefresh: c.refreshCallback,
          onLoading: c.loadMoreCallback,
          enablePullUp: true,
          child: ListView.builder(
            key: PageStorageKey('$state'),
            itemCount: c.offset,
            itemBuilder: (_, i) {
              var item = c.value[i];
              return TopicRowItemWidget(data: item);
            },
          ),
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(() => TopicAddPage(groupId: groupId));
          },
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
