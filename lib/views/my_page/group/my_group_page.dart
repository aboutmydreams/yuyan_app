import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:yuyan_app/models/component/user/view/view/one_group.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';

class MyGroup extends StatelessWidget {
  const MyGroup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<GroupData> groupList = topModel.myInfoManage.groupData.data;

    return Scaffold(
      appBar: AppBar(
        title: Text("我的团队"),
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: groupList.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: oneGroup(context, groupList[index]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
