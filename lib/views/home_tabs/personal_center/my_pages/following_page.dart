import 'package:flutter/material.dart';
import 'package:yuyan_app/config/viewstate/view_page.dart';
import 'package:yuyan_app/controller/global/my_controller.dart';
import 'package:yuyan_app/views/widget/animation.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';
import 'package:yuyan_app/views/component/nothing_page.dart';

class MyFollowingPage extends FetchRefreshListViewPage<MyFollowingController> {
  MyFollowingPage() : super(title: '我的关注');

  @override
  Widget buildChild() {
    var data = controller.value.data;
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (_, i) {
        return AnimationChildWidget(
          index: i,
          child: UserFollowTileWidget(
            isFollow: true,
            hideButton: false,
            user: data[i],
          ),
        );
      },
    );
  }

  @override
  Widget buildEmpty() => NothingPage(
        top: 50,
        text: "暂无关注~",
      );
}
