import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yuyan_app/controller/attend_controller.dart';
import 'package:yuyan_app/config/app_ui.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/views/widget/event_affair/affair_widget.dart';

class AttentionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GetBuilder<AttendController>(
        builder: (c) {
          return SmartRefresher(
            controller: c.refreshController,
            onRefresh: c.onRefreshCallback,
            enablePullUp: !c.isEmptyState,
            onLoading: c.onLoadMoreCallback,
            child: c.builder(
              (state) {
                var data = state.data;
                return ListView.builder(
                  key: PageStorageKey('attention'),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AffairTileWidget(data[index]);
                  },
                );
              },
              onEmpty: NothingPage(
                top: 100,
                text: "去关注一些人叭~",
              ),
            ),
          );
        },
      ),
    );
  }
}

