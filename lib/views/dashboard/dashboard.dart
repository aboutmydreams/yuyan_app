import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
            text: "快捷",
          ),
          Tab(
            text: "最近",
          ),
        ],
      ),
    ),

    body: TabBarView(
      children: <Widget>[
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
