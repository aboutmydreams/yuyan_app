import 'package:flutter/material.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/explore_page/search/search_bar.dart';
import 'attention/attention_page.dart';
import 'selection/selection_page.dart';

class ExplorePage extends StatefulWidget {
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarOpacity: 1.0,
          bottomOpacity: 5.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              tooltip: 'Search',
              onPressed: () {
                showSearch(context: context, delegate: searchBarDelegate());
              },
            )
          ],
          elevation: 0.0,
          title: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white.withOpacity(0.95),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3.0,
            tabs: <Widget>[
              Tab(
                text: "关注",
              ),
              Tab(
                text: "精选",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            GestureDetector(
              onPanDown: (DragDownDetails details) {
                topModel.bottomManage.initd();
              },
              child: Container(
                child: AttentionPage(),
              ),
            ),
            Container(
              child: SelectionPage(),
            ),
          ],
        ),
      ),
    );
  }
}
