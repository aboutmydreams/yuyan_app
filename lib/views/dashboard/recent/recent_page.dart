import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/state_manage/dataManage/recent_manage.dart';
import 'package:yuyan_app/views/dashboard/recent/view/one_recent.dart';

class RecentPage extends StatelessWidget {
  const RecentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<RecentData> recentDataList = topModel.recentManage.recentData.data;

    return ScopedModelDescendant<RecentManage>(
        builder: (context, child, model) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: aniColumn(
          children: model.recentData.data.map((oneRecentData) {
            return oneRecent(context, oneRecentData);
          }).toList(),
        ),
      );
    });

    // Column(
    //   children: recentDataList.map((oneRecentData) {
    //     return oneRecent(context, oneRecentData);
    //   }).toList(),
    // ),
  }
}
