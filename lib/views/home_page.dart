import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/controller/bottom_nav_controller.dart';
import 'package:yuyan_app/controller/theme_controller.dart';
import 'package:yuyan_app/views/explore_page/explore_page.dart';
import 'package:yuyan_app/views/my_page/my_page.dart';
import 'package:yuyan_app/views/news_page/news_page.dart';
import 'dashboard/dashboard.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.pageKey: 0}) : super(key: key);
  final int pageKey;

  @override
  _HomePageState createState() => _HomePageState(key: key, pageKey: pageKey);
}

class _HomePageState extends State<HomePage> {
  _HomePageState({Key key, int pageKey: 0});

  bool hideBottom = false;
  List<Widget> pageList = [];
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    pageList = [
      ExplorePage(),
      Dashboard(),
      NotificationPage(),
      MyPage(),
    ];

    super.initState();
  }

  Color iconColor(bool selected) {
    var theme = ThemeController.to;
    Color theColor = selected ? theme.primarySwatchColor : Colors.black87;
    return theColor;
  }

  _buildBottomNav(BottomNavigatorController controller) {
    var currIndex = controller.navIndex.value;
    return AnimatedBuilder(
      animation: controller.animation,
      builder: (context, child) {
        return Opacity(
          opacity: controller.height / 56,
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            color: Color.fromRGBO(0, 0, 0, 0.06),
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInQuad,
            height: controller.height,
            items: <Widget>[
              Icon(
                Icons.insert_emoticon,
                size: 34,
                color: iconColor(0 == currIndex),
              ),
              Icon(
                Icons.wrap_text,
                size: 34,
                color: iconColor(1 == currIndex),
              ),
              Badge(
                padding: EdgeInsets.all(0),
                badgeColor: Colors.transparent,
                elevation: 0,
                badgeContent: Icon(
                  Icons.notifications_none,
                  size: 34,
                  color: iconColor(2 == currIndex),
                ),
              ),
              Icon(
                Icons.perm_identity,
                size: 34,
                color: iconColor(3 == currIndex),
              ),
            ],
            animationDuration: Duration(milliseconds: 300),
            onTap: (index) {
              controller.navIndex.value = index;
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final double topPadding = MediaQuery.of(context).padding.bottom;
    // print(topPadding);
    var controller = Get.find<BottomNavigatorController>();
    return Scaffold(
      bottomNavigationBar: Obx(() => _buildBottomNav(controller)),
      body: NotificationListener<ScrollUpdateNotification>(
        child: Obx(() => pageList[controller.navIndex.value]),
        onNotification: controller.onUpdateNotification,
      ),
    );
  }
}
