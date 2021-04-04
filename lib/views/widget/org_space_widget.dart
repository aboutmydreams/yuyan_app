import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/controller/attend_controller.dart';
import 'package:yuyan_app/controller/global/organization_controller.dart';
import 'package:yuyan_app/controller/global/my_controller.dart';
import 'package:yuyan_app/controller/notification_controller.dart';
import 'package:yuyan_app/controller/quick_link_controller.dart';
import 'package:yuyan_app/controller/recent_controller.dart';
import 'package:yuyan_app/model/document/organization_lite.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/list_helper_widget.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

/// 切换空间组件
/// 先获取用户空间 List
/// 如果原始空间 List 为空，那么就不显示这个组件
/// 如果原始空间 List 不为空，初始化时在 List 中插入一个个人工作区
/// 用户点击该组件时弹窗选择空间

class OrgSpaceLeadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyUserController>(
      builder: (c) => c.builder((state) {
        return InkWell(
          child: IconButton(
            icon: UserAvatarWidget(
              avatar: state.data.avatarUrl,
            ),
            tooltip: '切换',
            onPressed: () {
              // 切换工作台弹窗
              Util.showWindow(
                title: "切换工作台",
                child: _OrgSpaceSelectDialog(),
              );
            },
          ),
        );
      }),
    );
  }
}

class _OrgSpaceSelectDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrganizationController>(
      init: OrganizationController(),
      builder: (c) => c.builder(
        (state) {
          var user = App.user.data;
          var defaultItem = OrganizationLiteSeri(
            name: user.name,
            logo: user.avatarUrl,
          );
          var data = [defaultItem, ...state.data];
          return AnimationColumnWidget(
            children: List.generate(
              data.length,
              (index) => _OrgSpaceItemWidget(org: data[index]),
            ),
          );
        },
        onLoading: Container(),
      ),
    );
  }
}

class _OrgSpaceItemWidget extends StatelessWidget {
  _OrgSpaceItemWidget({
    Key key,
    this.org,
  }) : super(key: key);

  final OrganizationLiteSeri org;

  _refreshController<T>() {
    try {
      var controller = Get.find<T>() as dynamic;
      try {
        controller.onRefreshCallback();
        debugPrint('do refresh on ${T.runtimeType}');
      } on NoSuchMethodError catch (e) {
        debugPrint('do refresh: $e');
      }
    } on String catch (e) {
      debugPrint('get controller: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String nowOrg = App.orgSpaceProvider.data?.login;
    bool isCurrent = nowOrg == org.login;
    return ListTile(
      selected: isCurrent,
      selectedTileColor: Colors.grey.withOpacity(0.2),
      leading: userAvatar(org.logo),
      title: Text(org.name),
      onTap: () async {
        if (!isCurrent) {
          App.orgSpaceProvider.data = org;
          Timer(Duration(milliseconds: 300), () {
            _refreshController<AttendController>();
            _refreshController<RecentController>();
            _refreshController<QuickLinkController>();
            _refreshController<NotificationReadController>();
            _refreshController<NotificationUnreadController>();
            _refreshController<NotificationSystemController>();
            Util.toast('切换成功');
            Get.back();
          });
        }
      },
    );
  }
}
