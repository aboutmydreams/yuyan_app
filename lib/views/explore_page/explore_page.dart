import 'package:flutter/material.dart';
import 'attention/attention_page.dart';
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
  length: 2,
  child: Scaffold(
    backgroundColor: Colors.grey[100],
    appBar: AppBar(
      backgroundColor: Colors.white,
      toolbarOpacity: 1.0,
      bottomOpacity: 5.0,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          tooltip: 'Search',
          onPressed: () => debugPrint('Search button is pressed.'),
        )
      ],
      elevation: 0.0,
      title: TabBar(
        labelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 3.0,
        tabs: <Widget>[
          Tab(
            text: "关注",
          ),
          Tab(
            text: "精选",
          ),
          // Tab(
          //   text: "广场",
          // ),
        ],
      ),
    ),

    body: TabBarView(
      children: <Widget>[
        Container(
          child: AttentionPage(),
        ),
        Container(
          child: SelectionPage(),
        ),
        // Container(
        //   child: Text("data"),
        // ),
      ],
    ),

    // bottomNavigationBar: BottomNavigationBarDemo(),
  ),
);
