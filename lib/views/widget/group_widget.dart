import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:yuyan_app/config/route_manager.dart';
import 'package:yuyan_app/model/document/group.dart';
import 'package:yuyan_app/config/app_ui.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class GroupTileWidgetFlat extends StatelessWidget {
  final iconType = {
    "Normal": "assets/images/dashboard/link.png",
    "Design": "assets/images/dashboard/design.png"
  };
  final GroupSeri group;

  GroupTileWidgetFlat({
    Key key,
    this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = group.avatarUrl ??
        iconType[group.type] ??
        "assets/images/explore/book.png";
    var child = Container(
      height: 70,
      child: Row(
        children: [
          SizedBox(width: 8),
          Hero(
            tag: '${group.id}',
            child: UserAvatarWidget(
              avatar: imageUrl,
              height: 48,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.name,
                  style: AppStyles.textStyleB,
                ),
                SizedBox(height: 2),
                Text(
                  group.description,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textStyleC,
                ).onlyIf(!GetUtils.isNullOrBlank(group.description)),
              ],
            ),
          ),
        ],
      ),
    );
    return GestureDetector(
      onTap: () {
        MyRoute.group(
          group: group,
          tag: '${group.id}',
        );
      },
      child: child,
    );
  }
}

class GroupTileWidget extends StatelessWidget {
  final iconType = {
    "Normal": "assets/images/dashboard/link.png",
    "Design": "assets/images/dashboard/design.png"
  };
  final GroupSeri group;

  GroupTileWidget({
    Key key,
    this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = group.avatarUrl ??
        iconType[group.type] ??
        "assets/images/explore/book.png";
    var child = Container(
      height: 70,
      // margin: EdgeInsets.only(top: 2, bottom: 9, left: 10, right: 10),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(25, 0, 0, 0),
            offset: Offset(1, 1),
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          SizedBox(width: 16),
          Hero(
            tag: '${group.id}',
            child: UserAvatarWidget(
              avatar: imageUrl,
              height: 50,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.name,
                  style: AppStyles.textStyleB,
                ),
                if (group.description != null)
                  Container(
                    child: Text(
                      group.description.clip(15, ellipsis: true),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.textStyleC,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
    return GestureDetector(
      onTap: () {
        MyRoute.group(
          group: group,
          tag: '${group.id}',
        );
      },
      child: child,
    );
  }
}
