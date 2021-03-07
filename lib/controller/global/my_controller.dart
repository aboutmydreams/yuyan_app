import 'package:flutter/material.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/service/api2_repository.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/config/viewstate/view_controller.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/model/document/action.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/group.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/model/topic/topic.dart';
import 'package:yuyan_app/model/v2/user_detail.dart';

class MyUserProvider extends BaseSaveJson<UserDetailSeri> {
  @override
  UserDetailSeri convert(json) {
    return UserDetailSeri.fromJson(json);
  }

  @override
  String get key => 'current_user';
}

class MyUserController extends FetchSavableController<MyUserProvider> {
  MyUserController()
      : super(
          initialRefresh: true,
          initData: App.user,
          state: ViewState.loading,
        );

  @override
  Future fetchData() {
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

class MyGroupController extends FetchSavableController<MyGroupProvider> {
  MyGroupController()
      : super(
          initialRefresh: true,
          initData: MyGroupProvider(),
          state: ViewState.loading,
        );

  @override
  Future fetchData() {
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
    extends FetchSavableController<MyFollowingProvider> {
  MyFollowingController()
      : super(
          initData: MyFollowingProvider(),
          initialRefresh: true,
          state: ViewState.loading,
        );

  @override
  Future fetchData() {
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

class MyFollowerController extends FetchSavableController<MyFollowerProvider> {
  MyFollowerController()
      : super(
          initData: MyFollowerProvider(),
          initialRefresh: true,
          state: ViewState.loading,
        );

  @override
  Future fetchData() {
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

class MyBookController extends FetchSavableController<MyBookProvider> {
  MyBookController()
      : super(
          initData: MyBookProvider(),
          initialRefresh: true,
          state: ViewState.loading,
        );

  @override
  Future fetchData() {
    return ApiRepository.getBookList(userId: App.user.data.id);
  }
}

class MyMarkProvider extends BaseSaveListJson<ActionSeri> {
  @override
  List<ActionSeri> convert(json) {
    return (json as List).map((e) => ActionSeri.fromJson(e)).toList();
  }

  @override
  String get key => 'user_my_mark';
}

class MyMarkController extends FetchSavableController<MyMarkProvider> {
  MyMarkController()
      : super(
          initData: MyMarkProvider(),
          initialRefresh: true,
          state: ViewState.loading,
        );

  @override
  Future fetchData() {
    return ApiRepository.getMarkList();
  }
}

class MyFollowBookProvider extends BaseSaveListJson<ActionSeri> {
  @override
  List<ActionSeri> convert(json) {
    return (json as List).map((e) => ActionSeri.fromJson(e)).toList();
  }

  @override
  String get key => 'user_follow_book';
}

class MyFollowBookController
    extends FetchSavableController<MyFollowBookProvider> {
  MyFollowBookController()
      : super(
          initData: MyFollowBookProvider(),
          initialRefresh: true,
          state: ViewState.loading,
        );

  @override
  Future fetchData() {
    return ApiRepository.getFollowBookList();
  }
}

class MyTopicProvider extends BaseSaveListJson<TopicSeri> {
  final String saveKey;

  MyTopicProvider(this.saveKey);

  @override
  List<TopicSeri> convert(json) {
    return (json as List).map((e) => TopicSeri.fromJson(e)).toList();
  }

  @override
  String get key => saveKey;
}

class MyTopicController extends FetchSavableController<MyTopicProvider> {
  final String topicState;

  MyTopicController({
    @required this.topicState,
  }) : super(
          initData: MyTopicProvider('my_user_topic_$topicState'),
          initialRefresh: true,
          state: ViewState.loading,
        );

  @override
  Future fetchData() {
    return ApiRepository.getMyTopics(
      type: 'participated',
      state: topicState,
    );
  }
}
