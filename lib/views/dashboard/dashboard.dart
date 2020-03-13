import 'package:flutter/material.dart';
import 'package:yuyan_app/state_manage/dataManage/data/quick_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/dashboard/quick/quick_view.dart';
import 'package:yuyan_app/views/dashboard/recent/recent_page.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Data> quickDataList = topModel.quickManage.quickData.data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        toolbarOpacity: 1.0,
        bottomOpacity: 5.0,
        elevation: 1,
        title: Text("书桌"),
        // 迭代计划中 工作台的搜索优先搜索我的
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(
        //       Icons.search,
        //       color: Colors.black,
        //     ),
        //     tooltip: 'Search',
        //     onPressed: () => debugPrint('Search button is pressed.'),
        //   )
        // ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.edit),
      // ),
      body: SingleChildScrollView(
        child: Column(children: [
          quickView(context, quickDataList),
          RecentPage(),
        ]),
      ),
    );
  }
}
