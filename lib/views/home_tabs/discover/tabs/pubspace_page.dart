import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuyan_app/util/styles/app_ui.dart';
import 'package:yuyan_app/controller/global/organization_controller.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/home_tabs/discover/widget/book_tile_widget.dart';
import 'package:yuyan_app/views/organization/widget/group.dart';

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
