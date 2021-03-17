import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/viewstate/view_page.dart';
import 'package:yuyan_app/controller/action_controller.dart';
import 'package:yuyan_app/controller/global/user_controller.dart';
import 'package:yuyan_app/model/events/user_lite_seri.dart';
import 'package:yuyan_app/models/widgets_small/menu_item.dart';
import 'package:yuyan_app/views/widget/book_row_widget.dart';
import 'package:yuyan_app/views/widget/follow_row_widget.dart';
import 'package:yuyan_app/views/widget/group_row_widget.dart';
import 'package:yuyan_app/views/widget/user_flexible_widget.dart';

class UserPage extends StatefulWidget {
  final UserLiteSeri user;
  final String heroTag;

  UserPage({
    Key key,
    @required this.user,
    this.heroTag,
  })  : assert(user != null),
        super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    int userId = widget.user.id;
    var tag = '$userId';
    Get.put(UserBookController(userId), tag: tag);
    Get.put(UserGroupController(userId), tag: tag);
    Get.put(UserFollowerController(userId), tag: tag);
    Get.put(UserFollowingController(userId), tag: tag);
    Get.put(FollowUserController(userId: userId), tag: tag);

    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  final List<String> _tabs = [
    "知识库",
    "团队",
    "关注了",
    "关注者",
  ];

  @override
  Widget build(BuildContext context) {
    var userId = widget.user.id;
    var controllerTag = '$userId';
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, inner) => [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('${widget.user.name}'),
            centerTitle: false,
            pinned: true,
            floating: false,
            snap: false,
            primary: true,
            expandedHeight: 230.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            stretchTriggerOffset: 10,
            elevation: 10,
            // 是否显示阴影，直接取值innerBoxIsScrolled，展开不显示阴影，合并后会显示
            forceElevated: inner,
            actions: <Widget>[
              GetBuilder<FollowUserController>(
                tag: controllerTag,
                builder: (c) => c.stateBuilder(
                  onLoading: SizedBox.shrink(),
                  onIdle: () => IconButton(
                    icon: (c.value ?? false)
                        ? Icon(Icons.star)
                        : Icon(Icons.star_border),
                    onPressed: c.toggle,
                  ),
                ),
              ),
              PopupMenuButton(
                itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  menuItem("A", "打开网页版"),
                  menuItem("B", "举报用户"),
                ],
                onSelected: (String action) {
                  // 点击选项的时候
                  // switch (action) {
                  //   case 'A':
                  //     openUrl(context, "https://www.yuque.com/$login");
                  //     break;
                  //   case 'B':
                  //     fakeReport(context);
                  // }
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: UserFlexibleWidget(
                user: widget.user,
                tag: widget.heroTag,
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white54,
              tabs: _tabs.map((e) => Tab(text: e)).toList(),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            FetchRefreshListViewBuilder<UserBookController>(
              tag: controllerTag,
              builder: (c) => c.stateBuilder(
                onIdle: () => ListView.builder(
                  itemCount: c.value.length,
                  itemBuilder: (_, i) => BookRowItemWidget(
                    book: c.value[i],
                  ),
                ),
              ),
            ),
            FetchRefreshListViewBuilder<UserGroupController>(
              tag: controllerTag,
              builder: (c) => c.stateBuilder(
                onIdle: () => ListView.builder(
                  itemCount: c.value.length,
                  itemBuilder: (_, i) => GroupRowItemWidget(
                    group: c.value[i],
                  ),
                ),
              ),
            ),
            FetchRefreshListViewBuilder<UserFollowingController>(
              tag: controllerTag,
              builder: (c) => c.stateBuilder(
                onIdle: () => ListView.builder(
                  itemCount: c.value.length,
                  itemBuilder: (_, i) => FollowRowItemWidget(
                    user: c.value[i],
                    hideButton: false,
                  ),
                ),
              ),
            ),
            FetchRefreshListViewBuilder<UserFollowerController>(
              tag: controllerTag,
              builder: (c) => c.stateBuilder(
                onIdle: () => ListView.builder(
                  itemCount: c.value.length,
                  itemBuilder: (_, i) => FollowRowItemWidget(
                    user: c.value[i],
                    hideButton: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
