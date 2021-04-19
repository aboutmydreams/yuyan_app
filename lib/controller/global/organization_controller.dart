import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/group.dart';
import 'package:yuyan_app/model/document/organization.dart';

import '../attend_controller.dart';
import '../notification_controller.dart';
import '../quick_link_controller.dart';
import '../recent_controller.dart';
import 'my_controller.dart';

class UserSpaceController extends FetchListValueController<OrganizationSeri> {
  @override
  Future<List<OrganizationSeri>> fetch() {
    return ApiRepository.getMyOrganizationList();
  }
}

class CurrSpaceProvider extends BaseSaveJson<OrganizationSeri> {
  bool get isDefault {
    if (data == null || data.login == null) {
      return true;
    }
    return App.userProvider.data.login == data.login;
  }

  _refreshController<T>() {
    try {
      var controller = Get.find<T>() as dynamic;
      try {
        controller.onRefreshCallback();
        debugPrint('do refresh on $T');
      } on NoSuchMethodError catch (e) {
        debugPrint('do refresh: $e');
        try {
          controller.refreshCallback();
        } on NoSuchMethodError catch (e) {
          debugPrint('do refresh: $e');
        }
      }
    } on String catch (e) {
      debugPrint('get controller: $e');
    }
  }

  changeSpace(OrganizationSeri newSpace) {
    data = newSpace;
    // 等待空间数据更变
    Future.delayed(Duration(milliseconds: 100), () {
      _refreshController<AttendController>();
      _refreshController<RecentController>();
      _refreshController<QuickLinkController>();
      _refreshController<NotificationAllController>();
      _refreshController<MyUserController>();
      _refreshController<OrgGroupController>();
      _refreshController<OrgBookController>();
      // _refreshController<MyBookController>();
      // _refreshController<MyFollowBookController>();
      // _refreshController<MyFollowingController>();
      // _refreshController<MyFollowerController>();
      // _refreshController<MyGroupController>();
      // TODO(@dreamer2q): 刷新全部消息

      print('isDefault => $isDefault');
    });
  }

  @override
  OrganizationSeri convert(json) {
    return OrganizationSeri.fromJson(json);
  }

  @override
  String get key => 'user_current_space';
}

class OrgBookController extends FetchListValueController<BookSeri> {
  @override
  Future<List<BookSeri>> fetch() {
    return ApiRepository.getOrgBookList();
  }
}

class OrgGroupController extends FetchListValueController<GroupSeri> {
  @override
  Future<List<GroupSeri>> fetch() {
    return ApiRepository.getOrgGroupList();
  }
}
