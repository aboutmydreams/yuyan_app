import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/controller/binding/app_binding.dart';
import 'package:yuyan_app/controller/global/my_controller.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/user/group/group.dart';
import 'package:yuyan_app/model/user/user_lite_seri.dart';
import 'package:yuyan_app/views/dashboard/dashboard.dart';
import 'package:yuyan_app/views/dashboard/note_editor/small_note_editor.dart';
import 'package:yuyan_app/views/dashboard/small_note/note_page.dart';
import 'package:yuyan_app/views/dashboard/small_note/quick_set.dart';
import 'package:yuyan_app/views/document_page/book_doc_page.dart';
import 'package:yuyan_app/views/document_page/doc_detail_page.dart';
import 'package:yuyan_app/views/document_page/doc_detail_webview.dart';
import 'package:yuyan_app/views/entry_page/guide/guide_page.dart';
import 'package:yuyan_app/views/entry_page/login/login_page.dart';
import 'package:yuyan_app/views/entry_page/splash/splash_page.dart';
import 'package:yuyan_app/views/group_page/group_page.dart';
import 'package:yuyan_app/views/home_page.dart';
import 'package:yuyan_app/views/my_page/my/follow_book_page.dart';
import 'package:yuyan_app/views/my_page/my/follower_page.dart';
import 'package:yuyan_app/views/my_page/my/following_page.dart';
import 'package:yuyan_app/views/my_page/my/my_book_page.dart';
import 'package:yuyan_app/views/my_page/my/my_group_page.dart';
import 'package:yuyan_app/views/my_page/my/my_mark_page.dart';
import 'package:yuyan_app/views/my_page/my/my_topic_page.dart';
import 'package:yuyan_app/views/my_page/setting/about_page.dart';
import 'package:yuyan_app/views/my_page/setting/setting_page.dart';
import 'package:yuyan_app/views/topic_page/topic_detail_page.dart';
import 'package:yuyan_app/views/user_page/user_page.dart';
import 'package:yuyan_app/views/webview_page/webview_page.dart';
import 'package:yuyan_app/views/widget/lake/lake_mention_widget.dart';

class RouteName {
  static const String home = '/';
  static const String guide = '/guide';
  static const String splash = '/first';
  static const String login = '/login';
  static const String desk = '/desk';
  static const String news = '/news';
  static const String my = '/my';
  static const String edit = '/edit';
  static const String editNote = '/edit/note';
  static const String quickSet = '/quickset';
  static const String dashboard = '/dashboard';
  static const String note = '/note';
  static const String mySetting = '/my/setting';
  static const String myGroup = '/my/group';
  static const String myFollower = '/my/follower';
  static const String myFollowing = '/my/following';
  static const String myFollowBook = '/my/follow_book';
  static const String myRepos = '/my/repos';
  static const String myMark = '/my/mark';
  static const String myTopic = '/my/topic';
  static const String myAbout = '/my/about';
  static const String mySuggest = '/my/suggest';

  static const String spaceEnsure = '/space_ensure';
}

class MyRoute {
  static topic(int iid, int groupId) {
    Get.to(
      TopicDetailPage(
        commentId: iid,
        groupId: groupId,
      ),
    );
  }

  static bookDocs(BookSeri book) {
    Get.to(
      BookDocPage(
        book: book,
      ),
      preventDuplicates: false,
    );
  }

  static webview(String url) {
    if (!url.startsWith('http')) {
      url = 'https://www.yuque.com' + url;
    }
    Get.to(
      WebviewPage(url: url),
      preventDuplicates: false,
    );
  }

  static docDetailWebview({
    @required int bookId,
    @required String slug,
    @required String login,
    @required String book,
  }) {
    Get.to(
      DocDetailWebviewPage(
        login: login,
        book: book,
        bookId: bookId,
        slug: slug,
      ),
    );
  }

  static docDetail({
    @required int bookId,
    @required String slug,
    @required String login,
    @required String book,
  }) {
    Get.to(
      DocDetailPage(
        bookId: bookId,
        slug: slug,
      ),
      preventDuplicates: false,
    );
  }

  // 打开其他用户的页面
  static user({
    @required UserLiteSeri user,
    String heroTag,
  }) {
    Get.to(
      UserPage(
        user: user,
        heroTag: heroTag,
      ),
      preventDuplicates: false,
    );
  }

  static userByLogin(String login) {
    Get.to(
      UserByLoginPage(login: login),
      preventDuplicates: false,
    );
  }

  static groupById(int groupId, [int index = 0]) {
    Get.to(
      GroupById(
        index: index,
        groupId: groupId,
      ),
      preventDuplicates: false,
    );
  }

  static group({
    @required GroupSeri group,
    String tag,
    int pageIndex = 0,
  }) {
    Get.to(
      GroupPage(
        group: group,
        heroTag: tag,
      ),
      preventDuplicates: false,
    );
  }

  static List<GetPage> pages = [
    GetPage(
      name: RouteName.home,
      page: () => HomePage(),
      binding: HomePageBinding(),
    ),
    GetPage(name: RouteName.splash, page: () => SplashPage()),
    GetPage(name: RouteName.guide, page: () => GuidePage()),
    GetPage(name: RouteName.login, page: () => LoginPage()),
    GetPage(name: RouteName.desk, page: () => HomePage(pageKey: 1)),
    GetPage(name: RouteName.news, page: () => HomePage(pageKey: 2)),
    GetPage(name: RouteName.my, page: () => HomePage(pageKey: 3)),
    GetPage(
      name: RouteName.editNote,
      page: () => SmallNoteEditor(),
    ),
    GetPage(name: RouteName.quickSet, page: () => QuickSetPage()),
    GetPage(
      name: RouteName.dashboard,
      page: () => MyDashBoardPage(),
    ),
    GetPage(
      name: RouteName.note,
      page: () => SmallNotePage(),
    ),
    GetPage(name: RouteName.mySetting, page: () => SettingPage()),
    GetPage(name: RouteName.myGroup, page: () => MyGroupPage()),
    GetPage(
      name: RouteName.myFollower,
      page: () => MyFollowerPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => MyFollowerController()),
      ),
    ),
    GetPage(
      name: RouteName.myFollowing,
      page: () => MyFollowingPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => MyFollowingController()),
      ),
    ),
    GetPage(
      name: RouteName.myFollowBook,
      page: () => MyFollowBookPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => MyFollowBookController()),
      ),
    ),
    GetPage(
      name: RouteName.myRepos,
      page: () => MyBooksPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => MyBookController()),
      ),
    ),
    GetPage(
      name: RouteName.myMark,
      page: () => MyMarkPage(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => MyMarkController()),
      ),
    ),
    GetPage(
      name: RouteName.myTopic,
      page: () => MyTopicPage(),
    ),
    GetPage(
      name: RouteName.myAbout,
      page: () => AboutPage(),
      middlewares: [OrgSpaceMiddleware()],
    ),
    GetPage(
      name: RouteName.mySuggest,
      page: () => GroupById(
        index: 2,
        groupId: 671004,
      ),
      middlewares: [OrgSpaceMiddleware()],
    ),
    GetPage(
      name: RouteName.spaceEnsure,
      page: () => SpaceEnsurePage(),
    ),
  ];
}

class SpaceEnsurePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('space_ensure_page: arguments=> ${Get.arguments}');
    return Scaffold(
      appBar: AppBar(
        title: Text('INFO'),
      ),
      body: Container(
        padding: const EdgeInsets.all(22),
        child: Center(
          child: Text(
            "当前所在的空间不支持此操作\n"
            "请回到个人空间后重试",
          ),
        ),
      ),
    );
  }
}

class OrgSpaceMiddleware extends GetMiddleware {
  @override
  RouteSettings redirect(String route) {
    switch (route) {
      case RouteName.myAbout:
      case RouteName.mySuggest:
        if (App.currentSpaceProvider.isDefault) {
          return null;
        }
        return RouteSettings(name: RouteName.spaceEnsure);
    }
    return null;
  }
}
