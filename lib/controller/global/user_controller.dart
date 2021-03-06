import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/service/api2_repository.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/model/document/group.dart';
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

class GroupProvider extends BaseSaveListJson<GroupSeri> {
  @override
  List<GroupSeri> convert(json) {
    return (json as List).map((e) => GroupSeri.fromJson(e)).toList();
  }

  @override
  String get key => 'user_group';
}

class GroupController extends FetchRefreshController<GroupProvider> {
  GroupController()
      : super(
          initialRefresh: true,
          initData: GroupProvider(),
          state: ViewState.loading,
        );

  @override
  Future refreshData() {
    return ApiRepository.getGroupList();
  }
}
