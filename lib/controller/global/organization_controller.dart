import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/model/document/organization_lite.dart';

///Organization对应一个语雀空间
class OrganizationProvider extends BaseSaveListJson<OrganizationLiteSeri> {
  @override
  List<OrganizationLiteSeri> convert(json) {
    return (json as List).map((e) => OrganizationLiteSeri.fromJson(e)).toList();
  }

  @override
  String get key => 'user_organization';
}

class OrganizationController
    extends FetchRefreshController<OrganizationProvider> {
  OrganizationController()
      : super(
          initData: OrganizationProvider(),
          initialRefresh: true,
          state: ViewState.loading,
        );

  @override
  Future refreshData() {
    return ApiRepository.getOrganizationList(userId: App.user.data.id);
  }
}

class OrgSpaceProvider extends BaseSaveJson<OrganizationLiteSeri> {
  @override
  OrganizationLiteSeri convert(json) {
    return OrganizationLiteSeri.fromJson(json);
  }

  @override
  String get key => 'user_current_space';
}
