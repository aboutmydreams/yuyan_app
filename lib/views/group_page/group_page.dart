import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/controller/action_controller.dart';
import 'package:yuyan_app/controller/global/group_controller.dart';
import 'package:yuyan_app/model/dashboard/quick_link_seri.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/doc_detail/contributors.dart';
import 'package:yuyan_app/model/document/group.dart';
import 'package:yuyan_app/model/document/group_home/book_stack.dart';
import 'package:yuyan_app/model/document/group_home/group_home_seri.dart';
import 'package:yuyan_app/model/document/group_home/summary.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/animation_widget.dart';
import 'package:yuyan_app/views/widget/book_row_widget.dart';
import 'package:yuyan_app/views/widget/drop_menu_item_widget.dart';
import 'package:yuyan_app/views/widget/topic_item_widget.dart';
import 'package:yuyan_app/views/widget/user_flexible_widget.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

import 'widget/group_home_widget.dart';

part 'widget/home_widget.dart';

class GroupPage extends StatefulWidget {
  final GroupSeri group;
  final String heroTag;

  const GroupPage({
    Key key,
    this.group,
    this.heroTag,
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
      length: _tabs.length,
      vsync: this,
    );

    var groupId = widget.group.id;
    tag = '$groupId';
    Get.put(GroupHomeController(groupId),tag: tag);
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
      body: NestedScrollView(
        headerSliverBuilder: (_, inner) => [
          SliverAppBar(
            leading: BackButton(),
            title: Text('${group.name}'),
            centerTitle: false,
            pinned: true,
            floating: false,
            snap: false,
            primary: true,
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

  _buildViews() {
    return [
      GetBuilder<GroupHomeController>(
        tag: tag,
        builder: (c) => c.stateBuilder(
          onEmpty: NothingPage(top: 190, text: "首页空空"),
          onIdle: () => _HomeWidget(items: c.value),
        ),
      ),
      GetBuilder<GroupBookController>(
        tag: tag,
        builder: (c) => c.stateBuilder(
          onIdle: () => AnimationListWidget(
            itemCount: c.value.length,
            itemBuilder: (_, i) => BookRowItemWidget(
              book: c.value[i],
            ),
          ),
        ),
      ),
      GetBuilder<GroupTopicController>(
        tag: tag,
        builder: (c) => c.stateBuilder(
          onIdle: () => AnimationListWidget(
            itemCount: c.value.length,
            itemBuilder: (_, i) => TopicRowItemWidget2(
              topic: c.value[i],
            ),
          ),
        ),
      ),
      GetBuilder<GroupMemberController>(
        tag: tag,
        builder: (c) => c.stateBuilder(
          onIdle: () => AnimationListWidget(
            itemCount: c.value.length,
            itemBuilder: (_, i) => UserFollowTileWidget(
              user: c.value[i].user,
              hideButton: false,
            ),
          ),
        ),
      ),
    ];
  }
}
