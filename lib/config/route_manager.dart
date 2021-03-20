import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/controller/binding/app_binding.dart';
import 'package:yuyan_app/controller/global/my_controller.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/group.dart';
import 'package:yuyan_app/model/events/user_lite_seri.dart';
import 'package:yuyan_app/models/component/edit_markdown/edit_page.dart';
import 'package:yuyan_app/views/begin_init/first_page/first_page.dart';
import 'package:yuyan_app/views/begin_init/guide_page/guide_page.dart';
import 'package:yuyan_app/views/begin_init/login_page/login_page.dart';
import 'package:yuyan_app/views/dashboard/dashboard.dart';
import 'package:yuyan_app/views/dashboard/quick/note/note_page.dart';
import 'package:yuyan_app/views/dashboard/quick/note_editor/note_editor.dart';
import 'package:yuyan_app/views/dashboard/quick/setting/quick_set.dart';
import 'package:yuyan_app/views/document_page/book_doc_page.dart';
import 'package:yuyan_app/views/document_page/doc_detail_page.dart';
import 'package:yuyan_app/views/group_page/group_page.dart';
import 'package:yuyan_app/views/home_page.dart';
import 'package:yuyan_app/views/my_page/my/follow_book_page.dart';
import 'package:yuyan_app/views/my_page/my/follower_page.dart';
import 'package:yuyan_app/views/my_page/my/following_page.dart';
import 'package:yuyan_app/views/my_page/my/my_book_page.dart';
import 'package:yuyan_app/views/my_page/my/my_group_page.dart';
import 'package:yuyan_app/views/my_page/my/my_mark_page.dart';
import 'package:yuyan_app/views/my_page/my/my_topic_page.dart';
import 'package:yuyan_app/views/my_page/setting/setting_page.dart';
import 'package:yuyan_app/views/topic_page/topic_detail_page.dart';
import 'package:yuyan_app/views/user_page/user_page.dart';
import 'package:yuyan_app/views/webview_page/webview_page.dart';
import 'package:yuyan_app/views/widget/lake_mention_widget.dart';

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

  static docDetail({
    @required int bookId,
    @required String slug,
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
    GetPage(name: RouteName.edit, page: () => FullPageEditorScreen()),
    GetPage(name: RouteName.editNote, page: () => MarkdownEditorPage()),
    GetPage(name: RouteName.quickSet, page: () => QuickSetPage()),
    GetPage(
      name: RouteName.dashboard,
      page: () => MyDashBoardPage(),
    ),
    GetPage(
      name: RouteName.note,
      page: () => QuickNotePage(),
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
    // GetPage(
    //   name: RouteName.myAbout,
    //   page: () => AboutYuyan(),
    // ),
    GetPage(
      name: RouteName.mySuggest,
      page: () {
        final avatarUrl =
            "https://cdn.nlark.com/yuque/0/2020/png/164272/1581178391840-avatar/dfd33ab4-7115-4fce-b504-faeb9d3ca24d.png";
        return GroupPage(
          group: GroupSeri(
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
