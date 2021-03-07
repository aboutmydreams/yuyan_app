import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/service/api2_repository.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/config/viewstate/view_fetch_controller.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/group.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/model/v2/user_detail.dart';

class UserProvider extends BaseSaveJson<UserDetailSeri> {
  @override
  UserDetailSeri convert(json) {
    return UserDetailSeri.fromJson(json);
  }

  @override
  String get key => 'current_user';
}

class UserController extends FetchRefreshController<UserProvider> {
  UserController()
      : super(
          initialRefresh: true,
          initData: App.user,
          state: ViewState.loading,
        );

  @override
  Future refreshData() {
    return Api2Repository.getUserDetail();
  }
}

class MyGroupProvider extends BaseSaveListJson<GroupSeri> {
  @override
  List<GroupSeri> convert(json) {
    return (json as List).map((e) => GroupSeri.fromJson(e)).toList();
  }

  @override
  String get key => 'user_group';
}

class MyGroupController extends FetchRefreshController<MyGroupProvider> {
  MyGroupController()
      : super(
          initialRefresh: true,
          initData: MyGroupProvider(),
          state: ViewState.loading,
        );

  @override
  Future refreshData() {
    return ApiRepository.getGroupList();
  }
}

class MyFollowingProvider extends BaseSaveListJson<UserSeri> {
  @override
  List<UserSeri> convert(json) {
    return (json as List).map((e) => UserSeri.fromJson(e)).toList();
  }

  @override
  String get key => 'user_my_following';
}

class MyFollowingController
    extends FetchRefreshController<MyFollowingProvider> {
  MyFollowingController()
      : super(
          initData: MyFollowingProvider(),
          initialRefresh: true,
          state: ViewState.loading,
        );

  @override
  Future refreshData() {
    return ApiRepository.getFollowingList(userId: App.user.data.id);
  }
}

class MyFollowerProvider extends BaseSaveListJson<UserSeri> {
  @override
  List<UserSeri> convert(json) {
    return (json as List).map((e) => UserSeri.fromJson(e)).toList();
  }

  @override
  String get key => 'user_my_follower';
}

class MyFollowerController extends FetchRefreshController<MyFollowerProvider> {
  MyFollowerController()
      : super(
          initData: MyFollowerProvider(),
          initialRefresh: true,
          state: ViewState.loading,
        );

  @override
  Future refreshData() {
    return ApiRepository.getFollowerList(userId: App.user.data.id);
  }
}

class MyBookProvider extends BaseSaveListJson<BookSeri> {
  @override
  List<BookSeri> convert(json) {
    return (json as List).map((e) => BookSeri.fromJson(e)).toList();
  }

  @override
  String get key => 'user_my_book';
}

class MyBookController extends FetchRefreshController<MyBookProvider> {
  MyBookController()
      : super(
          initData: MyBookProvider(),
          initialRefresh: true,
          state: ViewState.loading,
        );

  @override
  Future refreshData() {
    return ApiRepository.getBookList(userId: App.user.data.id);
  }
}
