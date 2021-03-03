import 'package:get/get.dart';
import 'package:yuyan_app/models/component/edit_markdown/edit_note.dart';
import 'package:yuyan_app/models/component/edit_markdown/edit_page.dart';
import 'package:yuyan_app/models/component/group/group_page.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';
import 'package:yuyan_app/views/begin_init/first_page/first_page.dart';
import 'package:yuyan_app/views/begin_init/guide_page/guide_page.dart';
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
import 'package:yuyan_app/views/my_page/repos/my_repos_page.dart';
import 'package:yuyan_app/views/my_page/setting/setting_page.dart';
import 'package:yuyan_app/views/my_page/topic/topic_page.dart';

// ZefyrController _controller;
// bool _editing = true;

class RouteName {
  static String home = '/';
  static String splash = '/first';
  static String guide = '/guide';
  static String login = '/login';
  static String desk = '/desk';
  static String news = '/news';
  static String my = '/my';
  static String edit = '/edit';
  static String editNote = '/edit/note';
  static String quickSet = '/quickset';
  static String dashboard = '/dashboard';
  static String note = '/note';
  static String mySetting = '/my/setting';
  static String myGroup = '/my/group';
  static String myFollower = '/my/follower';
  static String myFollowing = '/my/following';
  static String myFollowBook = '/my/follow_book';
  static String myRepos = '/my/repos';
  static String myMark = '/my/mark';
  static String myTopic = '/my/topic';
  static String myAbout = '/my/about';
  static String mySuggest = '/my/suggest';
}

class MyRoute {
  static List<GetPage> pages = [
    GetPage(name: RouteName.home, page: () => HomePage()),
    GetPage(name: RouteName.splash, page: () => SplashPage()),
    GetPage(name: RouteName.guide, page: () => GuidePage()),
    GetPage(name: RouteName.login, page: () => LoginPage()),
    GetPage(name: RouteName.desk, page: () => HomePage(pageKey: 1)),
    GetPage(name: RouteName.news, page: () => HomePage(pageKey: 2)),
    GetPage(name: RouteName.my, page: () => HomePage(pageKey: 3)),
    GetPage(name: RouteName.edit, page: () => FullPageEditorScreen()),
    GetPage(name: RouteName.editNote, page: () => EditNotePage()),
    GetPage(name: RouteName.quickSet, page: () => QuickSetPage()),
    GetPage(name: RouteName.dashboard, page: () => Dashboard()),
    GetPage(name: RouteName.note, page: () => NotePage()),
    GetPage(name: RouteName.mySetting, page: () => SettingPage()),
    GetPage(name: RouteName.myGroup, page: () => MyGroup()),
    GetPage(name: RouteName.myFollower, page: () => FollowerPage()),
    GetPage(name: RouteName.myFollowing, page: () => FollowingPage()),
    GetPage(name: RouteName.myFollowBook, page: () => FollowBookPage()),
    GetPage(name: RouteName.myRepos, page: () => MyReposPage()),
    GetPage(name: RouteName.myMark, page: () => MarkPage()),
    GetPage(name: RouteName.myTopic, page: () => TopicPage()),
    GetPage(name: RouteName.myAbout, page: () => AboutYuyan()),
    GetPage(
      name: RouteName.mySuggest,
      page: () {
        final avatarUrl =
            "https://cdn.nlark.com/yuque/0/2020/png/164272/1581178391840-avatar/dfd33ab4-7115-4fce-b504-faeb9d3ca24d.png";
        return GroupPage(
          pageIndex: 2,
          groupdata: GroupData(
            id: 671004,
            name: "语燕",
            description: "自缘不睹榴皮字，想像祇园蔓草书",
            avatarUrl: avatarUrl,
          ),
        );
      },
    ),
  ];
}
