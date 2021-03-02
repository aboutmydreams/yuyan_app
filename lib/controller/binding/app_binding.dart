import 'package:get/get.dart';
import 'file:///D:/Documents/Github/flutter/yuyan_app/lib/controller/bottom_nav_controller.dart';
import 'package:yuyan_app/controller/theme_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(BottomNavigatorController());
  }
}
