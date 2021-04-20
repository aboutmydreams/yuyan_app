import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/app_ui.dart';
import 'package:yuyan_app/controller/global/organization_controller.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/explore_page/widget/book_tile_widget.dart';
import 'package:yuyan_app/views/widget/group_widget.dart';
import 'package:yuyan_app/views/widget/org_space_widget.dart';
import 'package:yuyan_app/views/widget/search_action_widget.dart';
import 'attention/attention_page.dart';
import 'selection/selection_page.dart';

class ExplorePage extends StatefulWidget {
  final Key key;

  ExplorePage({this.key}) : super(key: key);

  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrSpaceProvider>(
      init: App.currentSpaceProvider,
      builder: (c) => Scaffold(
        appBar: AppBar(
          toolbarOpacity: 1.0,
          bottomOpacity: 5.0,
          leading: OrgSpaceLeadingWidget(),
          actions: [
            SearchActionWidget(),
          ],
          elevation: 0.0,
          title: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            indicatorColor: Colors.white.withOpacity(0.95),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3.0,
            tabs: [
              Tab(text: "关注"),
              Tab(text: "精选").onlyIf(
                c.isDefault,
                elseif: () => Tab(
                  text: '空间',
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          key: PageStorageKey('tab1_page'),
          controller: _tabController,
          children: [
            AttentionPage(),
            SelectionPage().onlyIf(
              c.isDefault,
              elseif: () => SpacePubPage(),
            ),
          ],
        ),
      ),
    );
  }
}

class SpacePubPage extends StatefulWidget {
  SpacePubPage({Key key}) : super(key: key);

  @override
  _SpacePubPageState createState() => _SpacePubPageState();
}

class _SpacePubPageState extends State<SpacePubPage>
    with AutomaticKeepAliveClientMixin {
  final _controller = RefreshController();

  @override
  void initState() {
    super.initState();

    Get.lazyPut(() => OrgBookController());
    Get.lazyPut(() => OrgGroupController());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Scrollbar(
        child: SmartRefresher(
          controller: _controller,
          onRefresh: () {
            var ref1 = Get.find<OrgBookController>();
            var ref2 = Get.find<OrgGroupController>();
            Future.wait([ref1.onRefresh(), ref2.onRefresh()]).then(
              (_) => _controller.refreshCompleted(),
            );
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                GetBuilder<OrgBookController>(
                  // init: OrgBookController(orgId),
                  builder: (c) => c.stateBuilder(
                    onIdle: () => TileListWidget(
                      title: '知识库',
                      children: c.value.mapWidget(
                        (item) => BookTileWidgetFlat(item: item),
                      ),
                    ),
                  ),
                ),
                GetBuilder<OrgGroupController>(
                  // init: OrgGroupController(orgId),
                  builder: (c) => c.stateBuilder(
                    onIdle: () => TileListWidget(
                      title: '团队',
                      children: c.value.mapWidget(
                        (item) => GroupTileWidgetFlat(group: item),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TileListWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool divide;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const TileListWidget({
    Key key,
    this.title,
    this.children,
    this.divide = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 4),
    this.margin = const EdgeInsets.all(8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: margin,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
            child: Text(title, style: AppStyles.textStyleB),
          ),
          Divider(height: 1),
          Padding(
            padding: padding,
            child: Column(
              children: children.mapWidget(
                (item) => item,
                divide: divide,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
