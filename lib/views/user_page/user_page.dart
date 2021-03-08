import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/viewstate/view_page.dart';
import 'package:yuyan_app/controller/action_controller.dart';
import 'package:yuyan_app/controller/global/user_controller.dart';
import 'package:yuyan_app/model/events/user_lite_seri.dart';
import 'package:yuyan_app/models/widgets_small/menu_item.dart';
import 'package:yuyan_app/util/util.dart';
import 'package:yuyan_app/views/widget/book_row_widget.dart';
import 'package:yuyan_app/views/widget/follow_row_widget.dart';
import 'package:yuyan_app/views/widget/group_row_widget.dart';
import 'package:yuyan_app/views/widget/user_flexible_widget.dart';

class UserPage extends StatefulWidget {
  final UserLiteSeri user;

  UserPage({
    Key key,
    @required this.user,
  })  : assert(user != null),
        super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    int userId = widget.user.id;
    Get.put(UserBookController(userId));
    Get.put(UserGroupController(userId));
    Get.put(UserFollowerController(userId));
    Get.put(UserFollowingController(userId));
    Get.put(FollowUserController(userId: userId));

    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  final List<String> _tabs = [
    "知识库",
    "团队",
    "关注了",
    "关注者",
  ];

  @override
  Widget build(BuildContext context) {
    var tag = Util.genHeroTag();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, inner) => [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('${widget.user.name}'),
            centerTitle: false,
            pinned: true,
            floating: false,
            snap: false,
            primary: true,
            expandedHeight: 230.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            stretchTriggerOffset: 10,
            elevation: 10,
            // 是否显示阴影，直接取值innerBoxIsScrolled，展开不显示阴影，合并后会显示
            forceElevated: inner,
            actions: <Widget>[
              GetBuilder<FollowUserController>(
                builder: (c) => c.stageBuilder(
                  onLoading: SizedBox.shrink(),
                  onIdle: () => IconButton(
                    icon: (c.value ?? false)
                        ? Icon(Icons.star)
                        : Icon(Icons.star_border),
                    onPressed: c.toggle,
                  ),
                ),
              ),
              PopupMenuButton(
                itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  menuItem("A", "打开网页版"),
                  menuItem("B", "举报用户"),
                ],
                onSelected: (String action) {
                  // 点击选项的时候
                  // switch (action) {
                  //   case 'A':
                  //     openUrl(context, "https://www.yuque.com/$login");
                  //     break;
                  //   case 'B':
                  //     fakeReport(context);
                  // }
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: UserFlexibleWidget(
                user: widget.user,
                tag: tag,
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white54,
              tabs: _tabs.map((e) => Tab(text: e)).toList(),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            FetchRefreshListViewBuilder<UserBookController>(
              builder: (c) => c.stageBuilder(
                onIdle: () => ListView.builder(
                  itemCount: c.value.length,
                  itemBuilder: (_, i) => BookRowItemWidget(
                    book: c.value[i],
                  ),
                ),
              ),
            ),
            FetchRefreshListViewBuilder<UserGroupController>(
              builder: (c) => c.stageBuilder(
                onIdle: () => ListView.builder(
                  itemCount: c.value.length,
                  itemBuilder: (_, i) => GroupRowItemWidget(
                    group: c.value[i],
                  ),
                ),
              ),
            ),
            FetchRefreshListViewBuilder<UserFollowingController>(
              builder: (c) => c.stageBuilder(
                onIdle: () => ListView.builder(
                  itemCount: c.value.length,
                  itemBuilder: (_, i) => FollowRowItemWidget(
                    user: c.value[i],
                    isFollow: true,
                  ),
                ),
              ),
            ),
            FetchRefreshListViewBuilder<UserFollowerController>(
              builder: (c) => c.stageBuilder(
                onIdle: () => ListView.builder(
                  itemCount: c.value.length,
                  itemBuilder: (_, i) => FollowRowItemWidget(
                    user: c.value[i],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//
// class UserPage extends StatefulWidget {
//   UserPage({
//     Key key,
//     this.login,
//     this.name,
//     this.userId,
//     this.avatarUrl,
//     this.description,
//     this.tag,
//     this.pageIndex,
//   }) : super(key: key);
//
//   final String login;
//   final int userId;
//   final String name;
//   final String avatarUrl;
//   final String description;
//   final String tag;
//   final int pageIndex;
//
//   @override
//   _UserPageState createState() => _UserPageState(
//         login: login,
//         name: name,
//         userId: userId,
//         avatarUrl: avatarUrl,
//         description: description,
//         pageIndex: pageIndex,
//         tag: tag,
//       );
// }
//
// class _UserPageState extends State<UserPage>
//     with SingleTickerProviderStateMixin {
//   _UserPageState({
//     Key key,
//     this.login,
//     this.name,
//     this.userId,
//     this.avatarUrl,
//     this.description,
//     this.tag,
//     this.pageIndex,
//   });
//
//   String login;
//   int userId;
//   String name;
//   String description;
//   String tag;
//   String avatarUrl;
//
//   int pageIndex;
//   bool isFollow = false;
//
//   List<String> _tabs = [
//     "知识库",
//     "团队",
//     "关注了",
//     "关注者",
//   ];
//
//   ProfileData profileJson;
//   UserInfoJson userInfoJson;
//   UserReposJson bookJson;
//   GroupJson groupJson;
//   Follows followsJson;
//   Follows followingJson;
//
//   @override
//   void initState() {
//     super.initState();
//     getProfile();
//     getIfFollow();
//     getInfo();
//     getBook();
//     getGroup();
//     getFollowing();
//     getFollower();
//   }
//
//   changeIndex(int index) {
//     if (mounted) {
//       setState(() {
//         pageIndex = index;
//       });
//     }
//   }
//
//   getProfile() async {
//     ProfileData profileData = await DioUser.getProfileData(userId: userId);
//     setState(() {
//       profileJson = profileData;
//     });
//   }
//
//   getInfo() async {
//     UserInfoJson info = await DioUser.getUserInfo(userId: userId);
//     setState(() {
//       userInfoJson = info;
//       _tabs[2] = _tabs[2] + " ${info.data.followingCount}";
//       _tabs[3] = _tabs[3] + " ${info.data.followersCount}";
//       description = info.data.description;
//     });
//   }
//
//   getIfFollow() async {
//     bool ifFollowHim = await DioUser.getIfFollow(userId: userId);
//     setState(() {
//       isFollow = ifFollowHim;
//     });
//   }
//
//   getBook() async {
//     UserReposJson book = await DioUser.getReposData(userId: userId);
//     setState(() {
//       bookJson = book;
//     });
//   }
//
//   getGroup() async {
//     GroupJson groupData = await DioUser.getGroupData(userId: userId);
//     setState(() {
//       groupJson = groupData;
//     });
//   }
//
//   getFollowing() async {
//     Follows followingData = await DioUser.getFollowingData(userId: userId);
//     setState(() {
//       followingJson = followingData;
//     });
//   }
//
//   getFollower() async {
//     Follows followsData = await DioUser.getFollowerData2(userId: userId);
//     setState(() {
//       followsJson = followsData;
//     });
//   }
//
//   changeFollow() async {
//     setState(() {
//       isFollow = !isFollow;
//     });
//     if (!isFollow) {
//       var ans = await DioUser.cancelFollow(userId: userId);
//       if (ans == 1) {
//         myToast(context, "有缘再会👋");
//         // topModel.myInfoManage.cancelFollow();
//       }
//     } else {
//       var ans = await DioUser.followUser(userId: userId);
//       if (ans == 1) {
//         myToast(context, "谢谢🙏");
//         // topModel.myInfoManage.addFollow();
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print(description);
//     return Scaffold(
//       body: DefaultTabController(
//         initialIndex: pageIndex,
//         length: _tabs.length,
//         child: NestedScrollView(
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             // These are the slivers that show up in the "outer" scroll view.
//             return <Widget>[
//               SliverOverlapAbsorber(
//                 handle:
//                     NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//                 sliver: SliverAppBar(
//                   leading: IconButton(
//                     icon: Icon(Icons.arrow_back),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   title: Text('$name'),
//                   centerTitle: false,
//                   pinned: true,
//                   floating: false,
//                   snap: false,
//                   primary: true,
//                   expandedHeight: 230.0,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6)),
//                   stretchTriggerOffset: 10,
//                   elevation: 10,
//                   // 是否显示阴影，直接取值innerBoxIsScrolled，展开不显示阴影，合并后会显示
//                   forceElevated: innerBoxIsScrolled,
//                   actions: <Widget>[
//                     IconButton(
//                       icon:
//                           isFollow ? Icon(Icons.star) : Icon(Icons.star_border),
//                       onPressed: () {
//                         changeFollow();
//                       },
//                     ),
//                     PopupMenuButton(
//                       itemBuilder: (BuildContext context) =>
//                           <PopupMenuItem<String>>[
//                         menuItem("A", "打开网页版"),
//                         menuItem("B", "举报用户"),
//                       ],
//                       onSelected: (String action) {
//                         // 点击选项的时候
//                         switch (action) {
//                           case 'A':
//                             openUrl(context, "https://www.yuque.com/$login");
//                             break;
//                           case 'B':
//                             fakeReport(context);
//                         }
//                       },
//                     ),
//                   ],
//
//                   flexibleSpace: FlexibleSpaceBar(
//                     background: userFlexSpace(
//                       context,
//                       description: description,
//                       userId: userId,
//                       avatarUrl: avatarUrl,
//                       tag: tag,
//                     ),
//                   ),
//
//                   bottom: TabBar(
//                     indicatorColor: Colors.white54,
//                     tabs: _tabs.map((String name) => Tab(text: name)).toList(),
//                   ),
//                 ),
//               ),
//             ];
//           },
//           body: TabBarView(
//             children: [
//               UserBookPage(bookJson: bookJson),
//               UserGroupPage(groupJson: groupJson),
//               FollowingPage(followingJson: followingJson),
//               FollowerPage(followerJson: followsJson),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
