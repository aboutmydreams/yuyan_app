import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuyan_app/controller/notification_controller.dart';
import 'package:yuyan_app/config/app_ui.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/news_page/view/one_news.dart';
import 'package:yuyan_app/views/widget/org_space_widget.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    Get.put(NotificationAllController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: OrgSpaceLeadingWidget(),
        title: Text("全部消息"),
      ),
      body: GetBuilder<NotificationAllController>(
        builder: (c) => c.stateBuilder(
          onIdle: () => Column(
            children: [
              _buildCounts(c),
              Expanded(
                child: Scrollbar(
                  child: SmartRefresher(
                    controller: c.refreshController,
                    onRefresh: c.onRefreshCallback,
                    child: ListView.builder(
                      itemCount: c.value.length,
                      itemBuilder: (_, i) {
                        var item = c.value[i];
                        return NotificationItemWidget(
                          data: item,
                          unread: item.readAt == null,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCounts(NotificationAllController c) {
    return Container(
      height: 38,
      // 通过增加 margin 来体现出边框的效果
      margin: const EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(128, 101, 101, 101),
            offset: Offset(0, 0),
            blurRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 6),
        child: Row(
          children: [
            Text(
              '暂无未读消息',
              style: AppStyles.textStyleBB,
            ).when(
              c.hasUnread == false,
              other: () => Badge(
                child: Text('未读消息'),
                elevation: 5,
                toAnimate: false,
                shape: BadgeShape.square,
                badgeColor: Colors.yellow,
                alignment: Alignment.centerLeft,
                animationType: BadgeAnimationType.fade,
                borderRadius: BorderRadius.circular(8),
                position: BadgePosition.topEnd(end: -36, top: -2),
                animationDuration: Duration(milliseconds: 50),
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 4,
                ),
                badgeContent: Text(
                  '${c.unread.normalCount}',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: "Silom",
                    fontWeight: FontWeight.w700,
                    fontSize: 9,
                  ),
                ),
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.done_all),
              onPressed: c.readAll,
            ),
          ],
        ),
      ),
    );
  }
}
