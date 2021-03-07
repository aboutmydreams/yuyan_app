import 'package:flutter/material.dart';
import 'package:yuyan_app/config/viewstate/view_page.dart';
import 'package:yuyan_app/controller/global/user_controller.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/views/widget/animation_widget.dart';
import 'package:yuyan_app/views/widget/follow_row_widget.dart';

class MyFollowerPage extends FetchRefreshListViewPage<MyFollowerController> {
  MyFollowerPage() : super(title: '关注我的');

  @override
  Widget buildChild() {
    var data = controller.value.data;
    return AnimationListWidget(
      itemCount: data.length,
      itemBuilder: (_, i) {
        return FollowRowItemWidget(user: data[i]);
      },
    );
  }

  @override
  Widget buildEmpty() {
    return NothingPage(
      top: 50,
      text: "暂无关注者",
    );
  }
}
