import 'package:get/get.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/controller/attend_controller.dart';
import 'package:yuyan_app/controller/bottom_nav_controller.dart';
import 'package:yuyan_app/controller/explore_controller.dart';
import 'package:yuyan_app/controller/global/my_controller.dart';
import 'package:yuyan_app/controller/global/organization_controller.dart';
import 'package:yuyan_app/controller/quick_link_controller.dart';
import 'package:yuyan_app/controller/recent_controller.dart';
import 'package:yuyan_app/controller/theme_controller.dart';
import 'package:yuyan_app/controller/version_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(BottomNavigatorController());

    Get.put(App.currentSpaceProvider);

    Get.lazyPut(() => VersionController(), fenix: true);
  }
}

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AttendController());

    Get.put(RecentController());
    Get.put(QuickLinkController());

    Get.put(MyUserController());

    Get.put(ExploreSelectionController());
    Get.put(ExploreRecommendController());
    Get.put(OrgBookController());
    Get.put(OrgGroupController());

    Get.lazyPut(() => MyGroupController());
    Get.lazyPut(() => MyBookController());
    Get.lazyPut(() => MyFollowingController());
    Get.lazyPut(() => MyFollowerController());
  }
}
