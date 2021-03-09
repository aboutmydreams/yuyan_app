import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/controller/binding/app_binding.dart';
import 'package:yuyan_app/controller/global/my_controller.dart';
import 'package:yuyan_app/model/document/group.dart';
import 'package:yuyan_app/model/events/user_lite_seri.dart';
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
import 'package:yuyan_app/views/document_page/doc_detail_page.dart';
import 'package:yuyan_app/views/home_page.dart';
import 'package:yuyan_app/views/my_page/about_yuyan/about.dart';
import 'package:yuyan_app/views/my_page/my/follow_book_page.dart';
import 'package:yuyan_app/views/my_page/my/follower_page.dart';
import 'package:yuyan_app/views/my_page/my/following_page.dart';
import 'package:yuyan_app/views/my_page/my/my_book_page.dart';
import 'package:yuyan_app/views/my_page/my/my_group_page.dart';
import 'package:yuyan_app/views/my_page/my/my_mark_page.dart';
import 'package:yuyan_app/views/my_page/my/my_topic_page.dart';
import 'package:yuyan_app/views/my_page/setting/setting_page.dart';
import 'package:yuyan_app/views/user_page/user_page.dart';

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

// 打开文档
// static doc(BuildContext context, {int bookId, int docId}) {
//   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//     return DocPage(
//       bookId: bookId,
//       docId: docId,
//     );
//   }));
// }
//
// static docWeb(BuildContext context,
//     {String login,
//       String bookSlug,
//       String url,
//       int bookId,
//       int docId,
//       bool onlyUser}) {
//   Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//     return DocPageWeb(
//       login: login,
//       url: url,
//       bookSlug: bookSlug,
//       bookId: bookId,
//       docId: docId,
//       onlyUser: onlyUser,
//     );
//   }));
// }
//
//
//   // 打开团队页面

//
//   // 打开文档知识库
//   static docBook(BuildContext context,
//       {int bookId, String bookSlug, String login, bool onlyUser}) {
//     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//       return BookDocPage(
//         bookId: bookId,
//         bookSlug: bookSlug,
//         login: login,
//         onlyUser: onlyUser,
//       );
//     }));
//   }
//
//   // 打开画板知识库
//
//   // 打开话题知识库
//
//   // 打开话题
//   static topic(BuildContext context, {int id, int iid, int groupId}) {
//     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//       return TopicDetail(id: id, iid: iid, groupId: groupId);
//     }));
//   }
//
//   // 打开搜索
//   static search(BuildContext context,
//       {String text, bool aboutMe, int pageIndex}) {
//     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//       return SearchResultPage(
//           text: text, aboutMe: aboutMe, pageIndex: pageIndex);
//     }));
//   }
// }
//

class MyRoute {
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

  static group({
    @required GroupSeri group,
    int pageIndex = 0,
  }) {
    Get.to(
      GroupPage2(group: group),
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
    GetPage(name: RouteName.editNote, page: () => EditNotePage()),
    GetPage(name: RouteName.quickSet, page: () => QuickSetPage()),
    GetPage(
      name: RouteName.dashboard,
      page: () => Dashboard(),
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
    GetPage(
      name: RouteName.myAbout,
      page: () => AboutYuyan(),
    ),
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
