import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/nothing.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';

import 'view/one_group.dart';

class UserGroupPage extends StatelessWidget {
  UserGroupPage({Key key, this.groupJson}) : super(key: key);
  final GroupJson groupJson;

  @override
  Widget build(BuildContext context) {
    return groupJson == null
        ? loading()
        : groupJson.data.isEmpty
            ? NothingPage(top: 190, text: "没有公开团队")
            : SingleChildScrollView(
                child: aniColumn(
                  aniWhich: 4,
                  children: [SizedBox(height: 155)]
                    ..addAll(groupJson.data.map((a) {
                      return oneGroup(context, a);
                    }).toList()),
                ),
              );
  }
}
