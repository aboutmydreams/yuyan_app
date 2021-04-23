import 'package:flutter/material.dart';
import 'package:yuyan_app/config/viewstate/view_page.dart';
import 'package:yuyan_app/controller/global/my_controller.dart';
import 'package:yuyan_app/views/widget/animation.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';
import 'package:yuyan_app/views/component/nothing_page.dart';

class MyFollowerPage extends FetchRefreshListViewPage<MyFollowerController> {
  MyFollowerPage() : super(title: '关注我的');

  @override
  Widget buildChild() {
    var data = controller.value.data;
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (_, i) {
        return AnimationChildWidget(
          index: i,
          child: UserFollowTileWidget(
            user: data[i],
            hideButton: false,
          ),
        );
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
