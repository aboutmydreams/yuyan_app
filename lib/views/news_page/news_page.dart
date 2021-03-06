import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/controller/notification_controller.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/state_manage/dataManage/mydata_manage.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/util/analytics.dart';
import 'package:yuyan_app/views/news_page/view/one_news/one_news.dart';
import 'package:yuyan_app/views/widget/notification_absorb.dart';
import 'package:yuyan_app/views/widget/org_space_widget.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  // int count;
  // ScrollController _controller;
  // List<Notifications> unreadList = topModel.newsManage.unreadNews.notifications;
  // List<Notifications> readedList = topModel.newsManage.readedNews.notifications;

  TabController tabController;

  @override
  void initState() {
    super.initState();
    // if (unreadList != null) {
    //   count = unreadList.length;
    // }

    Get.put(NotificationReadController());
    Get.put(NotificationUnreadController());
    Get.put(NotificationSystemController());

    tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  // // 下拉刷新函数
  // Future onfresh() async {
  //   topModel.newsManage.update();
  //   await Future.delayed(
  //     const Duration(milliseconds: 1500),
  //     () {
  //       setState(() {
  //         unreadList = topModel.newsManage.unreadNews.notifications;
  //         readedList = topModel.newsManage.readedNews.notifications;
  //         if (unreadList != null) {
  //           myToast(context, "已更新");
  //         } else {
  //           myToast(context, "稍后试一试");
  //         }
  //       });
  //     },
  //   );
  // }

  Widget buildList(NotificationController controller) {
    return controller.builder((state) {
      var data = state.data;
      return SmartRefresher(
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoadMore,
        enablePullUp: true,
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (_, index) {
            var item = data[index];
            // 先展示未读消息列表，再显示最近已读消息列表
            return NotificationItemWidget(
              data: item,
              unread: false,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    analytics.logEvent(name: 'news_page');
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: ScopedModel<MyInfoManage>(
          model: topModel.myInfoManage,
          child: OrgSpaceLeadingWidget(),
        ),
        title: Text("全部消息"),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(text: '未讀消息'),
            Tab(text: '已讀消息'),
            Tab(text: '系統消息'),
          ],
        ),
      ),
      body: NotificationAbsorbWidget(
        child: TabBarView(
          controller: tabController,
          children: [
            GetBuilder<NotificationUnreadController>(
              builder: buildList,
            ),
            GetBuilder<NotificationReadController>(
              builder: buildList,
            ),
            GetBuilder<NotificationSystemController>(
              builder: buildList,
            ),
          ],
        ),
      ),
    );
  }
}
