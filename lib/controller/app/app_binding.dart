import 'package:get/get.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/controller/home/attend_controller.dart';
import 'package:yuyan_app/controller/app/bottom_nav_controller.dart';
import 'package:yuyan_app/controller/home/explore_controller.dart';
import 'package:yuyan_app/controller/home/notification/notification_controller.dart';
import 'package:yuyan_app/controller/home/notification/notificaton_service.dart';
import 'package:yuyan_app/controller/home/personal/my_controller.dart';
import 'package:yuyan_app/controller/home/quick_link_controller.dart';
import 'package:yuyan_app/controller/home/recent_controller.dart';
import 'package:yuyan_app/controller/app/theme_controller.dart';
import 'package:yuyan_app/controller/app/version_controller.dart';

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

    Get.lazyPut(() => MyGroupController());
    Get.lazyPut(() => MyBookController());
    Get.lazyPut(() => MyFollowingController());
    Get.lazyPut(() => MyFollowerController());

    Future.delayed(10.seconds, () {
      Get.put(NotificationService());
    });
  }
}
