import 'package:flutter/material.dart';
import 'package:yuyan_app/state_manage/dataManage/data/recent_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/dashboard/recent/view/one_recent.dart';

class RecentPage extends StatelessWidget {
  const RecentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Recent> recentDataList = topModel.recentManage.recentData.data;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: recentDataList.map((f) {
          return oneRecent(context, f);
        }).toList(),
      ),
    );
  }
}
