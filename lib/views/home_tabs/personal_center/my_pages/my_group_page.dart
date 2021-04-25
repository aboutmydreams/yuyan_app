import 'package:flutter/material.dart';
import 'package:yuyan_app/config/viewstate/view_page.dart';
import 'package:yuyan_app/controller/home/personal/my_controller.dart';
import 'package:yuyan_app/views/organization/widget/group.dart';
import 'package:yuyan_app/views/widget/animation.dart';

class MyGroupPage extends FetchRefreshListViewPage<MyGroupController> {
  MyGroupPage() : super(title: "我的团队");

  @override
  Widget buildChild() {
    var data = controller.value.data;
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (_, index) {
        return AnimationChildWidget(
          index: index,
          child: GroupTileWidget(
            group: data[index],
          ),
        );
      },
    );
  }
}
