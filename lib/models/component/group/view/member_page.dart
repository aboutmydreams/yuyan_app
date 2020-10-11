import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/user/view/view/one_user.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_member_data.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';

class MemberPage extends StatefulWidget {
  MemberPage({Key key, this.memberJson}) : super(key: key);
  final MemberJson memberJson;

  @override
  _MemberPageState createState() => _MemberPageState(memberJson: memberJson);
}

class _MemberPageState extends State<MemberPage> {
  _MemberPageState({Key key, this.memberJson});
  MemberJson memberJson;

  @override
  Widget build(BuildContext context) {
    return memberJson == null
        ? loading()
        : SingleChildScrollView(
            child: aniColumn(
                aniWhich: 4,
                children: [SizedBox(height: 155)]..addAll(
                    memberJson.data.map((a) {
                      return oneUser(context, setMemberData(a));
                    }).toList(),
                  )),
          );
  }
}

Map<String, dynamic> setMemberData(MemberData data) {
  return {
    "login": data.user.login,
    "userId": data.userId,
    "avatarUrl": data.user.avatarUrl,
    "description": data.user.description,
    "name": data.user.name,
  };
}
