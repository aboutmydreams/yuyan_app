import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuyan_app/config/viewstate/view_page.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/config/viewstate/view_state_widget.dart';
import 'package:yuyan_app/controller/action_controller.dart';
import 'package:yuyan_app/controller/global/group_controller.dart';
import 'package:yuyan_app/model/user/group/group.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/organization/topic_page/all_topic_page.dart';
import 'package:yuyan_app/views/organization/topic_page/topic_add_page.dart';
import 'package:yuyan_app/views/organization/topic_page/topic_item_widget.dart';
import 'package:yuyan_app/views/widget/action/floating_action_button_widget.dart';
import 'package:yuyan_app/views/organization/widget/book_row_widget.dart';
import 'package:yuyan_app/views/widget/menu_item.dart';
import 'package:yuyan_app/views/organization/widget/user_flexible_widget.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

import 'widget/home_widget.dart';

class GroupPage extends StatefulWidget {
  final int initialIndex;
  final GroupSeri group;
  final String heroTag;

  const GroupPage({
    Key key,
    this.group,
    this.heroTag,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage>
    with SingleTickerProviderStateMixin {
  final List<String> _tabs = [
    "首页",
    "知识库",
    "讨论区",
    "成员",
  ];

  TabController _tabController;
  String tag;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      initialIndex: widget.initialIndex,
      length: _tabs.length,
      vsync: this,
    );

    var groupId = widget.group.id;
    tag = '$groupId';
    Get.put(GroupHomeController(groupId), tag: tag);
    Get.put(GroupStackController(groupId), tag: tag);
    Get.put(GroupMemberController(groupId), tag: tag);
    Get.put(GroupBookController(groupId), tag: tag);
    Get.put(GroupTopicController(groupId), tag: tag);
    Get.put(GroupMarkController(targetId: groupId), tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    var group = widget.group;
    return Scaffold(
      body: extended.NestedScrollView(
        pinnedHeaderSliverHeightBuilder: () => Util.pinnedHeight,
        innerScrollPositionKeyBuilder: () {
          var key = 'group_page_tab_${_tabController.index}';
          return Key(key);
        },
        headerSliverBuilder: (_, inner) => [
          SliverAppBar(
            leading: BackButton(),
            title: Text('${group.name}'),
            // centerTitle: false,
            pinned: true,
            // floating: false,
            // snap: false,
            // primary: true,
            expandedHeight: 230.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            stretchTriggerOffset: 10,
            elevation: 10,
            forceElevated: inner,
            actions: <Widget>[
              GetBuilder<GroupMarkController>(
                tag: widget.heroTag ?? tag,
                builder: (c) => c.stateBuilder(
                  onLoading: SizedBox.shrink(),
                  onError: (_) => SizedBox.shrink(),
                  onIdle: () => IconButton(
                    icon: c.value ? Icon(Icons.star) : Icon(Icons.star_border),
                    onPressed: c.toggle,
                  ),
                ),
              ),
              PopupMenuButton<VoidCallback>(
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: () {
                      Util.goUrl('/go/group/${widget.group.id}');
                    },
                    child: MenuItemWidget(
                      iconData: Icons.open_in_browser,
                      title: '打开网页版',
                    ),
                  ),
                  PopupMenuItem(
                    value: () {
                      Get.to(() => GroupTopicAllPage(groupId: widget.group.id));
                    },
                    child: MenuItemWidget(
                      iconData: Icons.topic,
                      title: '讨论区',
                    ),
                  ),
                ],
                onSelected: (_) => _?.call(),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: UserFlexibleWidget(
                user: group.toUserLiteSeri(),
                tag: widget.heroTag,
              ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.white54,
              controller: _tabController,
              tabs: _tabs.map((String name) => Tab(text: name)).toList(),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: _buildViews(),
        ),
      ),
    );
  }

  List<Widget> _buildViews() {
    return [
      //首页
      GetBuilder<GroupHomeController>(
        key: Key('group_page_tab_0'),
        tag: tag,
        builder: (c) => c.stateBuilder(
          onEmpty: ViewEmptyWidget(tip: "首页空空"),
          onIdle: () => GroupHomeWidget(
            groupId: widget.group.id,
            items: c.value,
            meta: c.meta,
          ),
        ),
      ),
      //知识库
      FetchRefreshListViewBuilder<GroupBookController>(
        key: Key('group_page_tab_1'),
        tag: tag,
        nested: true,
        builder: (c) => ListView.builder(
          itemCount: c.value.length,
          itemBuilder: (_, i) => BookRowItemWidget(
            book: c.value[i],
          ),
        ),
      ),
      //讨论区
      GetBuilder<GroupTopicController>(
        tag: tag,
        autoRemove: false,
        builder: (c) => c.stateBuilder(
          onError: (err) {
            if (err.type != ViewErrorType.api) return null;
            return Container(
              alignment: Alignment.center,
              child: Text('讨论区未开启'),
            );
          },
          onEmpty: ViewEmptyWidget(
            tip: '还没有话题，快来开启吧',
            child: ViewButtonWidget(
              icon: Icon(Icons.add_rounded),
              onPressed: () {
                var c = Get.find<GroupTopicController>(tag: tag);
                Get.to(TopicAddPage(groupId: c.groupId))
                    .then((_) => c.onRefresh());
              },
              child: Text('创建话题'),
            ),
          ),
          onIdle: () => FloatingActionWidget(
            button: Icon(Icons.add),
            onPressed: () => Get.to(
              TopicAddPage(groupId: c.groupId),
            ).then((_) => c.onRefresh()),
            child: extended.NestedScrollViewInnerScrollPositionKeyWidget(
              Key('group_page_tab_2'),
              Scrollbar(
                child: SmartRefresher(
                  controller: c.refreshController,
                  onLoading: c.loadMoreCallback,
                  onRefresh: c.refreshCallback,
                  enablePullUp: true,
                  child: ListView.builder(
                    itemCount: c.value.length,
                    itemBuilder: (_, i) => TopicTileWidget(
                      topic: c.value[i],
                      showLabel: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      //成员
      FetchRefreshListViewBuilder<GroupMemberController>(
        key: Key('group_page_tab_3'),
        tag: tag,
        nested: true,
        builder: (c) => ListView.builder(
          itemCount: c.value.length,
          itemBuilder: (_, i) => UserFollowTileWidget(
            user: c.value[i].user,
            hideButton: false,
          ),
        ),
      ),
    ];
  }
}
