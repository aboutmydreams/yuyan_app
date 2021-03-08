import 'package:flutter/material.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/document/group.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class GroupRowItemWidget extends StatelessWidget {
  final iconType = {
    "Normal": "assets/images/dashboard/link.png",
    "Design": "assets/images/dashboard/design.png"
  };
  final GroupSeri group;

  GroupRowItemWidget({
    Key key,
    this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = group.avatarUrl.startsWith("http")
        ? group.avatarUrl
        : iconType[group.type] ?? "assets/images/explore/book.png";
    // data.avatarUrl = imageUrl;
    return GestureDetector(
      onTap: () {
        MyRoute.group(group: group);
      },
      child: Container(
        height: 70,
        margin: EdgeInsets.only(top: 2, bottom: 9, left: 10, right: 10),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(25, 0, 0, 0),
              offset: Offset(1, 2),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(9.5)),
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Hero(
                tag: group.id,
                child: UserAvatarWidget(
                  avatar: imageUrl,
                  height: 50,
                ),
              ),
            ),
            Text(
              group.name,
              style: AppStyles.textStyleB,
            )
          ],
        ),
      ),
    );
  }
}
