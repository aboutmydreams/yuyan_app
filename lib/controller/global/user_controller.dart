import 'package:yuyan_app/config/service/api2_repository.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/group.dart';
import 'package:yuyan_app/model/document/note/note.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/model/v2/user_detail.dart';

class UserInfoController extends FetchValueController<UserDetailSeri> {
  final int userId;

  UserInfoController(this.userId);

  @override
  Future<UserDetailSeri> fetch() {
    return Api2Repository.getUserDetail(userId: userId);
  }
}

class UserGroupController extends FetchListValueController<GroupSeri> {
  final int userId;

  UserGroupController(this.userId);

  @override
  Future<List<GroupSeri>> fetch() {
    return ApiRepository.getGroupList(userId: userId);
  }
}

class UserFollowerController extends FetchListValueController<UserSeri> {
  final int userId;

  UserFollowerController(this.userId);

  @override
  Future<List<UserSeri>> fetch() {
    return ApiRepository.getFollowerList(userId: userId);
  }
}

class UserFollowingController extends FetchListValueController<UserSeri> {
  final int userId;

  UserFollowingController(this.userId);

  @override
  Future<List<UserSeri>> fetch() {
    return ApiRepository.getFollowingList(userId: userId);
  }
}

class UserBookController extends FetchListValueController<BookSeri> {
  final int userId;

  UserBookController(this.userId);

  @override
  Future<List<BookSeri>> fetch() {
    return ApiRepository.getBookList(userId: userId);
  }
}

class NoteDetailController extends FetchValueController<NoteSeri> {
  final int noteId;

  NoteDetailController(this.noteId);

  @override
  Future<NoteSeri> fetch() {
    return ApiRepository.getNoteDetail(noteId: noteId);
  }
}
