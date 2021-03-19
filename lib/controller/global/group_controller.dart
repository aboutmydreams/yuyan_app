import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/group_home/book_stack.dart';
import 'package:yuyan_app/model/document/group_home/group_home_seri.dart';
import 'package:yuyan_app/model/document/group_user.dart';
import 'package:yuyan_app/model/topic/topic.dart';

class GroupHomeController extends FetchListValueController<GroupViewBlockSeri> {
  final int groupId;

  GroupHomeController(this.groupId);

  @override
  Future<List<GroupViewBlockSeri>> fetch() {
    return ApiRepository.getGroupHome(groupId: groupId);
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

  GroupTopicController(this.groupId);

  @override
  Future<List<TopicSeri>> fetch() {
    return ApiRepository.getTopicList(groupId: groupId);
  }
}
