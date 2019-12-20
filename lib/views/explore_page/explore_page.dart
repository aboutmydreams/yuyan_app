import 'package:flutter/material.dart';

import 'selection/selection_page.dart';

class ExplorePage extends StatefulWidget {
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return theController;
  }
}

DefaultTabController theController = DefaultTabController(
  length: 3,
  child: Scaffold(
    backgroundColor: Colors.grey[100],
    appBar: AppBar(
      toolbarOpacity: 1.0,
      bottomOpacity: 5.0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          tooltip: 'Search',
          onPressed: () => debugPrint('Search button is pressed.'),
        )
      ],
      elevation: 0.0,
      title: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 3.0,
        tabs: <Widget>[
          Tab(
            text: "语雀精选",
          ),
          Tab(
            text: "文章",
          ),
          Tab(
            text: "知识库",
          ),
        ],
      ),
    ),

    body: TabBarView(
      children: <Widget>[
        Container(
          child: SelectionPage(),
        ),
        Container(
          child: Text("data"),
        ),
        Container(
          child: Text("data"),
        ),
      ],
    ),

    // bottomNavigationBar: BottomNavigationBarDemo(),
  ),
);
