import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/controller/app/bottom_nav_controller.dart';
import 'package:yuyan_app/controller/app/theme_controller.dart';

import 'home_tabs/dashboard/dashboard.dart';
import 'home_tabs/discover/discover.dart';
import 'home_tabs/notification/notification.dart';
import 'home_tabs/personal_center/personal_center.dart';

/// Creating new different type of documentation
class CreateDocPage extends StatefulWidget {
  @override
  _CreateDocPageState createState() => _CreateDocPageState();
}

class _CreateDocPageState extends State<CreateDocPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("创建"),
      ),
      body: Container(
        child: Text('.'),
      ),
    );
  }
}

class Home extends StatefulWidget {
  final int pageIndex;

  Home({
    Key key,
    this.pageIndex = 0,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pageList = [];
  DateTime _prevBackTime = DateTime.now();
  RxInt tabIndex;

  @override
  void initState() {
    super.initState();

    tabIndex = RxInt(widget.pageIndex);

    pageList = [
      DiscoverTab(),
      DashboardTab(),
      // CreateDocPage(),
      NotificationTab(),
      PersonalCenterTab(),
    ];
  }

  Color iconColor(bool selected) {
    var theme = ThemeController.to;
    Color theColor = selected ? theme.primarySwatchColor : Colors.black87;
    return theColor;
  }

  _buildBottomNav(BottomNavigatorController controller) {
    var currIndex = tabIndex.value;

    debugPrint('_buildbottomNav');

    final items = [
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
      // TODO(@dreamer2q): considering add a center-docked button
      // GestureDetector(
      //   onTap: () {},
      //   child: Transform.translate(
      //     offset: Offset(0, -6),
      //     child: Container(
      //       width: 64,
      //       height: 64,
      //       decoration: BoxDecoration(
      //         color: Colors.green,
      //         shape: BoxShape.circle,
      //       ),
      //       child: Icon(
      //         Icons.add,
      //       ),
      //     ),
      //   ),
      // ),
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
    ];

    return AnimatedBuilder(
      animation: controller.animation,
      builder: (context, child) {
        return Opacity(
          opacity: controller.height / 56,
          child: CurvedNavigationBar(
            animationDuration: Duration(milliseconds: 300),
            color: Color.fromRGBO(0, 0, 0, 0.06),
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInQuad,
            height: controller.height,
            items: items,
            onTap: (index) {
              tabIndex.value = index;
              debugPrint('tabIndex: $index');
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<BottomNavigatorController>();

    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        if (now.difference(_prevBackTime) > 1.seconds) {
          Fluttertoast.showToast(msg: '再按一次退出');
          _prevBackTime = now;
          return false;
        }
        return true;
      },
      child: Scaffold(
        // floatingActionButton: Transform.translate(
        // offset: Offset(0, 16),
        //   child: FloatingActionButton(
        //     onPressed: () {},
        //     child: Icon(Icons.add),
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Obx(() => _buildBottomNav(controller)),
        body: NotificationListener<ScrollUpdateNotification>(
          child: Obx(() => pageList[tabIndex.value]),
          onNotification: controller.onUpdateNotification,
        ),
      ),
    );
  }
}
