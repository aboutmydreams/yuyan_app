import 'package:yuyan_app/config/service/api2_repository.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/user/group/group.dart';
import 'package:yuyan_app/model/document/group_home/book_stack.dart';
import 'package:yuyan_app/model/document/note/doclet.dart';
import 'package:yuyan_app/model/document/note/note.dart';
import 'package:yuyan_app/model/user/mine/mine_seri.dart';
import 'package:yuyan_app/model/user/user.dart';
import 'package:yuyan_app/model/user/events/event_seri.dart';
import 'package:yuyan_app/model/v2/user_detail.dart';

class UserInfoController extends FetchValueController<MineSeri> {
  final int userId;
  final String login;

  UserInfoController({this.userId, this.login});

  @override
  Future<MineSeri> fetch() {
    return ApiRepository.getMineInfo();
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

class UserStackController extends FetchValueController<BookStackSeri> {
  final int userId;

  UserStackController(this.userId);

  @override
  Future<BookStackSeri> fetch() {
    return ApiRepository.getUserBookStack(userId: userId);
  }
}

class UserReadmeController extends FetchValueController<DocletSeri> {
  final int userId;

  UserReadmeController(this.userId);

  @override
  Future<DocletSeri> fetch() {
    return ApiRepository.getUserReadme(userId: userId);
  }
}

class UserEventsController extends FetchListValueController<EventSeri> {
  final int userId;

  UserEventsController(this.userId);

  bool hasMore = true;

  Future<List<EventSeri>> _doFetch([bool loadmore = false]) async {
    var res = await ApiRepository.getUserEvents(
      userId: userId,
      limit: 20,
      offset: loadmore ? offset : 0,
    );

    var list = (res.data as List).map((e) => EventSeri.fromJson(e)).toList();
    hasMore = (res.meta['hasMore'] ?? false);
    return list;
  }

  @override
  Future<List<EventSeri>> fetch() async {
    return _doFetch();
  }

  @override
  Future<List<EventSeri>> fetchMore() {
    return _doFetch(true);
  }
}
