import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:yuyan_app/config/viewstate/view_page.dart';
import 'package:yuyan_app/controller/global/my_controller.dart';
import 'package:yuyan_app/views/widget/group_widget.dart';

class MyGroupPage extends FetchRefreshListViewPage<MyGroupController> {
  MyGroupPage() : super(title: "我的团队");

  @override
  Widget buildChild() {
    var data = controller.value.data;
    return ListView.builder(
      // itemCount: groupList.length,
      itemCount: data.length,
      itemBuilder: (_, int index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: GroupTileWidget(group: data[index]),
            ),
          ),
        );
      },
    );
  }
}
