import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/edit_markdown/add_doc/edit_page.dart';
import 'package:yuyan_app/models/component/edit_markdown/add_doc/edit_page_test-dev.2.0.dart';
import 'package:yuyan_app/models/component/group/group_page.dart';
import 'package:yuyan_app/models/widgets_big/image_page/test1.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';
import 'package:yuyan_app/views/begin_init/first_page/first_page.dart';
import 'package:yuyan_app/views/begin_init/guide_page/guide_page.dart';
import 'package:yuyan_app/views/begin_init/guide_page/test.dart';
import 'package:yuyan_app/views/begin_init/login_page/login_page.dart';
import 'package:yuyan_app/views/dashboard/dashboard.dart';
import 'package:yuyan_app/views/dashboard/quick/note/note_page.dart';
import 'package:yuyan_app/views/dashboard/quick/setting/quick_set.dart';
import 'package:yuyan_app/views/home_page.dart';
import 'package:yuyan_app/views/my_page/about_yuyan/about.dart';
import 'package:yuyan_app/views/my_page/follow_book/follow_book_page.dart';
import 'package:yuyan_app/views/my_page/follower/follower_page.dart';
import 'package:yuyan_app/views/my_page/following/following_page.dart';
import 'package:yuyan_app/views/my_page/group/my_group_page.dart';
import 'package:yuyan_app/views/my_page/mark/mark_page.dart';
import 'package:yuyan_app/views/my_page/my_page.dart';
import 'package:yuyan_app/views/my_page/repos/my_repos_page.dart';
import 'package:yuyan_app/views/my_page/setting/setting_page.dart';
import 'package:yuyan_app/views/my_page/topic/topic_page.dart';
import 'package:zefyr/zefyr.dart';

import 'dev_test/firebase_analytics.dart';

ZefyrController _controller;
bool _editing = true;

Map<String, WidgetBuilder> routeData = {
  '/': (context) => HomePage(),
  '/desk': (context) => HomePage(pageKey: 1),
  '/news': (context) => HomePage(pageKey: 2),
  '/my': (context) => HomePage(pageKey: 3),
  // '/first': (context) => GalleryExample(),
  // '/first': (context) => AboutYuyan(),
  // '/first': (context) => MyAnalyPage(),
  '/edit': (context) => FullPageEditorScreen(),
  '/first': (context) => FirstPage(),
  '/login': (context) => LoginPage(),
  '/guide': (context) => GuidePage(),
  '/quickset': (context) => QuickSetPage(),
  '/dashboard': (context) => Dashboard(),
  '/note': (context) => NotePage(),
  '/my/setting': (context) => SettingPage(),
  '/my/group': (context) => MyGroup(),
  '/my/follower': (context) => FollowerPage(),
  '/my/following': (context) => FollowingPage(),
  '/my/follow_book': (context) => FollowBookPage(),
  '/my/repos': (context) => MyReposPage(),
  '/my/mark': (context) => MarkPage(),
  '/my/topic': (context) => TopicPage(),
  '/my/about': (context) => AboutYuyan(),
  '/my/suggest': (context) => GroupPage(
      pageIndex: 2,
      groupdata: GroupData(
          id: 671004,
          name: "语燕",
          description: "自缘不睹榴皮字，想像祇园蔓草书",
          avatarUrl:
              "https://cdn.nlark.com/yuque/0/2020/png/164272/1581178391840-avatar/dfd33ab4-7115-4fce-b504-faeb9d3ca24d.png")),
};
