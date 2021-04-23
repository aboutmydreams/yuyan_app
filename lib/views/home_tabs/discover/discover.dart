import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/controller/organization/organization_controller.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/organization/widget/org_spacet.dart';
import 'package:yuyan_app/views/search/search_action_widget.dart';
import 'tabs/attention_page.dart';
import 'tabs/pubspace_page.dart';
import 'tabs/selection_page.dart';

class DiscoverTabview extends StatefulWidget {
  final Key key;

  DiscoverTabview({this.key}) : super(key: key);

  _DiscoverTabviewState createState() => _DiscoverTabviewState();
}

class _DiscoverTabviewState extends State<DiscoverTabview>
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
