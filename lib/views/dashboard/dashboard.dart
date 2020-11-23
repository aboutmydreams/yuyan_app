import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/state_manage/dataManage/data/quick_data.dart';
import 'package:yuyan_app/state_manage/dataManage/mydata_manage.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/dashboard/quick/quick_view.dart';
import 'package:yuyan_app/views/dashboard/recent/recent_page.dart';
import 'package:yuyan_app/views/explore_page/search/search_bar.dart';
import 'package:yuyan_app/views/explore_page/view/org_leading.dart';

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
        leading: ScopedModel<MyInfoManage>(
          model: topModel.myInfoManage,
          child: OrgLeading(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            tooltip: '搜索与我有关',
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchBarDelegate(aboutMe: true),
              );
            },
          )
        ],
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
