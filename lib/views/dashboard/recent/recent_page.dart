import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/state_manage/dataManage/data/recent_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/dashboard/recent/view/one_recent.dart';

class RecentPage extends StatelessWidget {
  const RecentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<RecentData> recentDataList = topModel.recentManage.recentData.data;
    return Container(
        width: MediaQuery.of(context).size.width,
        child: aniColumn(
          children: recentDataList.map((oneRecentData) {
            return oneRecent(context, oneRecentData);
          }).toList(),
        )

        // Column(
        //   children: recentDataList.map((oneRecentData) {
        //     return oneRecent(context, oneRecentData);
        //   }).toList(),
        // ),
        );
  }
}
