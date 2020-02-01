import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
      child: AnimationLimiter(
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: recentDataList.map((oneRecentData) {
              return oneRecent(context, oneRecentData);
            }).toList(),
          ),
        ),
      ),

      // Column(
      //   children: recentDataList.map((oneRecentData) {
      //     return oneRecent(context, oneRecentData);
      //   }).toList(),
      // ),
    );
  }
}
