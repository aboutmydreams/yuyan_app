import 'package:flutter/material.dart';
import 'package:yuyan_app/config/service/api2_repository.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/group_home/book_stack.dart';
import 'package:yuyan_app/model/document/group_home/group_home_seri.dart';
import 'package:yuyan_app/model/document/group_user.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/model/events/user_event_seri.dart';
import 'package:yuyan_app/model/topic/topic.dart';

class GroupInfoController extends FetchValueController<UserSeri> {
  final int groupId;

  GroupInfoController(this.groupId);

  @override
  Future<UserSeri> fetch() {
    return Api2Repository.getGroupDetail(groupId: groupId);
  }
}

class GroupViewBlockController extends FetchListValueController<UserEventSeri> {
  final int blockId;

  GroupViewBlockController(this.blockId);

  int offset = 0;
  bool hasMore = false;

  Future<List<UserEventSeri>> _do([bool refresh = false]) async {
    var resp = await ApiRepository.getViewBlocks(
      blockId: blockId,
      offset: refresh ? 0 : offset,
    );
    offset = resp.item2.meta['offset'] ?? 0;
    hasMore = resp.item2.meta['hasMore'] ?? false;
    return resp.item1;
  }

  @override
  Future<List<UserEventSeri>> fetch() => _do(true);

  @override
  Future<List<UserEventSeri>> fetchMore() => _do(false);
}

class GroupHomeController extends FetchListValueController<GroupViewBlockSeri> {
  final int groupId;

  GroupHomeController(this.groupId);

  Map meta;

  @override
  Future<List<GroupViewBlockSeri>> fetch() async {
    var tup = await ApiRepository.getGroupHome(groupId: groupId);
    meta = tup.item2.meta;
    return tup.item1;
  }
}

class GroupStackController extends FetchListValueController<BookStackSeri> {
  final int groupId;

  GroupStackController(this.groupId);

  @override
  Future<List<BookStackSeri>> fetch() {
    return ApiRepository.getBookStack(groupId: groupId);
  }
}

class GroupBookController extends FetchListValueController<BookSeri> {
  final int groupId;

  GroupBookController(this.groupId);

  @override
  Future<List<BookSeri>> fetch() {
    return ApiRepository.getBookList(userId: groupId);
  }
}

class GroupMemberController extends FetchListValueController<GroupUserSeri> {
  final int groupId;

  GroupMemberController(this.groupId);

  @override
  Future<List<GroupUserSeri>> fetch() {
    return ApiRepository.getGroupMemberList(groupId: groupId);
  }
}

class GroupTopicController extends FetchListValueController<TopicSeri> {
  final int groupId;
  final String topicState;

  GroupTopicController(this.groupId, [this.topicState = 'open']);

  @override
  Future<List<TopicSeri>> fetch() {
    return ApiRepository.getTopicList(groupId: groupId, state: topicState);
  }

  @override
  Future<List<TopicSeri>> fetchMore() {
    return ApiRepository.getTopicList(
        groupId: groupId, state: topicState, offset: offset);
  }
}
