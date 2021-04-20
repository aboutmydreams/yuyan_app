import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuyan_app/config/viewstate/view_page.dart';
import 'package:yuyan_app/controller/action_controller.dart';
import 'package:yuyan_app/controller/global/user_controller.dart';
import 'package:yuyan_app/model/user/user_lite_seri.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/book_row_widget.dart';
import 'package:yuyan_app/views/widget/book_stack_widget.dart';
import 'package:yuyan_app/views/widget/drop_menu_item_widget.dart';
import 'package:yuyan_app/views/widget/group_widget.dart';
import 'package:yuyan_app/views/widget/lake/lake_render_widget.dart';
import 'package:yuyan_app/views/widget/user_flexible_widget.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';
import 'package:yuyan_app/views/widget/event_affair/affair_widget.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

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
      length: _tabs.length,
      vsync: this,
    );
  }

  final List<String> _tabs = [
    "首页",
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
      body: extended.NestedScrollView(
        pinnedHeaderSliverHeightBuilder: () => Util.pinnedHeight,
        innerScrollPositionKeyBuilder: () {
          return Key('user_page_tab_${_tabController.index}');
        },
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
              PopupMenuButton<VoidCallback>(
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: () {
                      Util.goUrl('/go/user/${widget.user.id}');
                    },
                    child: MenuItemWidget(
                      iconData: Icons.open_in_browser,
                      title: '打开网页版',
                    ),
                  ),
                  // PopupMenuItem(
                  //   value: () {
                  //     Get.to(() => GroupTopicAllPage(groupId: widget.group.id));
                  //   },
                  //   child: MenuItemWidget(
                  //     iconData: Icons.topic,
                  //     title: '讨论区',
                  //   ),
                  // ),
                ],
                onSelected: (_) => _?.call(),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: UserFlexibleWidget(
                user: widget.user,
                tag: widget.heroTag,
              ),
            ),
            bottom: TabBar(
              isScrollable: true,
              controller: _tabController,
              indicatorColor: Colors.white54,
              tabs: _tabs.map((e) => Tab(text: e)).toList(),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _UserHomeWidget(
              key: Key('user_page_tab_0'),
              userId: userId,
            ),
            FetchRefreshListViewBuilder<UserBookController>(
              key: Key('user_page_tab_1'),
              nested: true,
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
              key: Key('user_page_tab_2'),
              tag: controllerTag,
              builder: (c) => c.stateBuilder(
                onIdle: () => ListView.builder(
                  itemCount: c.value.length,
                  itemBuilder: (_, i) => GroupTileWidget(
                    group: c.value[i],
                  ),
                ),
              ),
            ),
            FetchRefreshListViewBuilder<UserFollowingController>(
              key: Key('user_page_tab_3'),
              tag: controllerTag,
              builder: (c) => c.stateBuilder(
                onIdle: () => ListView.builder(
                  itemCount: c.value.length,
                  itemBuilder: (_, i) => UserFollowTileWidget(
                    user: c.value[i],
                    hideButton: false,
                  ),
                ),
              ),
            ),
            FetchRefreshListViewBuilder<UserFollowerController>(
              key: Key('user_page_tab_4'),
              tag: controllerTag,
              builder: (c) => c.stateBuilder(
                onIdle: () => ListView.builder(
                  itemCount: c.value.length,
                  itemBuilder: (_, i) => UserFollowTileWidget(
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

class _UserHomeWidget extends StatelessWidget {
  final int userId;

  String get tag => '$userId';

  _UserHomeWidget({
    Key key,
    this.userId,
  }) : super(key: key);

  final RefreshController _refresh = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: extended.NestedScrollViewInnerScrollPositionKeyWidget(
        key,
        Scrollbar(
          child: SmartRefresher(
            controller: _refresh,
            onRefresh: () async {
              await Future.wait([
                Util.refreshController<UserReadmeController>(tag: tag),
                Util.refreshController<UserStackController>(tag: tag),
                Util.refreshController<UserEventsController>(tag: tag),
              ]);
              _refresh.refreshCompleted();
            },
            child: ListView(
              children: [
                _buildReadme(),
                _buildBookStack(),
                _buildEvents(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReadme() {
    return GetBuilder<UserReadmeController>(
      init: UserReadmeController(userId),
      autoRemove: false,
      tag: tag,
      builder: (c) => c.stateBuilder(
        onIdle: () => Container(
          padding: const EdgeInsets.only(top: 20),
          child: LakeRenderWidget(
            data: c.value.bodyAsl ?? '',
          ),
        ),
      ),
    );
  }

  Widget _buildBookStack() {
    return GetBuilder<UserStackController>(
      init: UserStackController(userId),
      autoRemove: false,
      tag: tag,
      builder: (c) => c.stateBuilder(
        onIdle: () => BookStackWidget(
          stack: [c.value],
        ),
      ),
    );
  }

  Widget _buildEvents() {
    return GetBuilder<UserEventsController>(
      init: UserEventsController(userId),
      autoRemove: false,
      tag: tag,
      builder: (c) => c.stateBuilder(
        onIdle: () => Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: c.offset,
              itemBuilder: (_, i) {
                var item = c.value[i];
                return AffairTileWidget(item);
              },
            ),
            if (c.hasMore)
              Container(
                child: ElevatedButton(
                  onPressed: c.loadMoreCallback,
                  child: Text('加载更多'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
