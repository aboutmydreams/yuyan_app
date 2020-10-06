import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/book_doc/view/one_user.dart';
import 'package:yuyan_app/models/component/open_page.dart';
import 'package:yuyan_app/models/component/web/open_url.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_member_data.dart';
import 'package:yuyan_app/models/tools/clear_text.dart';
import 'package:yuyan_app/models/tools/get_tag.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/loading.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';

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
                      return oneMember(context, setMemberData(a));
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
