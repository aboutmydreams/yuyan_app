import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/user/view/book_page.dart';
import 'package:yuyan_app/models/component/user/view/flex_space.dart';
import 'package:yuyan_app/models/component/user/view/follower_page.dart';
import 'package:yuyan_app/models/component/user/view/following_page.dart';
import 'package:yuyan_app/models/component/user/view/groups_page.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_follow_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_info_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_profile_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_repos_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/user.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';

class UserPage extends StatefulWidget {
  UserPage(
      {Key key,
      this.login,
      this.name,
      this.userId,
      this.avatarUrl,
      this.description,
      this.tag,
      this.pageIndex})
      : super(key: key);
  final String login;
  final int userId;
  final String name;
  final String avatarUrl;
  final String description;
  final String tag;
  final int pageIndex;

  @override
  _UserPageState createState() => _UserPageState(
        login: login,
        name: name,
        userId: userId,
        avatarUrl: avatarUrl,
        description: description,
        pageIndex: pageIndex,
        tag: tag,
      );
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  _UserPageState(
      {Key key,
      this.login,
      this.name,
      this.userId,
      this.avatarUrl,
      this.description,
      this.tag,
      this.pageIndex});
  String login;
  int userId;
  String name;
  String description;
  String tag;
  String avatarUrl;

  int pageIndex;
  bool isFollow = false;

  List<String> _tabs = [
    "知识库",
    "团队",
    "关注了",
    "关注者",
  ];

  ProfileData profileJson;
  UserInfoJson userInfoJson;
  UserBookJson bookJson;
  GroupJson groupJson;
  Follows followsJson;
  Follows followingJson;

  @override
  void initState() {
    super.initState();
    getProfile();
    getIfFollow();
    getInfo();
    getBook();
    getGroup();
    getFollowing();
    getFollower();
  }

  changeIndex(int index) {
    if (mounted) {
      setState(() {
        pageIndex = index;
      });
    }
  }

  getProfile() async {
    ProfileData profileData = await DioUser.getProfileData(userId: userId);
    setState(() {
      profileJson = profileData;
    });
  }

  getInfo() async {
    UserInfoJson info = await DioUser.getUserInfo(userId: userId);
    setState(() {
      userInfoJson = info;
      _tabs[2] = _tabs[2] + " ${info.data.followingCount}";
      _tabs[3] = _tabs[3] + " ${info.data.followersCount}";
      description = info.data.description;
    });
  }

  getIfFollow() async {
    bool ifFollowHim = await DioUser.getIfFollow(userId: userId);
    setState(() {
      isFollow = ifFollowHim;
    });
  }

  getBook() async {
    UserBookJson book = await DioUser.getReposData(login: login);
    setState(() {
      bookJson = book;
    });
  }

  getGroup() async {
    GroupJson groupData = await DioUser.getGroupData(userId: userId);
    setState(() {
      groupJson = groupData;
    });
  }

  getFollowing() async {
    Follows followingData = await DioUser.getFollowingData(userId: userId);
    setState(() {
      followingJson = followingData;
    });
  }

  getFollower() async {
    Follows followsData = await DioUser.getFollowerData2(userId: userId);
    setState(() {
      followsJson = followsData;
    });
  }

  changeFollow() async {
    setState(() {
      isFollow = !isFollow;
    });
    if (isFollow) {
      var ans = await DioUser.cancelFollow(userId: userId);
      print(ans);
    } else {
      var ans = await DioUser.followUser(userId: userId);
      print(ans);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(description);
    return Scaffold(
      body: DefaultTabController(
        initialIndex: pageIndex,
        length: _tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: Text('$name'),
                  centerTitle: false,
                  pinned: true,
                  floating: false,
                  snap: false,
                  primary: true,
                  expandedHeight: 230.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  stretchTriggerOffset: 10,
                  elevation: 10,
                  // 是否显示阴影，直接取值innerBoxIsScrolled，展开不显示阴影，合并后会显示
                  forceElevated: innerBoxIsScrolled,

                  actions: <Widget>[
                    IconButton(
                      icon:
                          isFollow ? Icon(Icons.star) : Icon(Icons.star_border),
                      onPressed: () {
                        changeFollow();
                      },
                    ),
                  ],

                  flexibleSpace: FlexibleSpaceBar(
                    background: userFlexSpace(
                      context,
                      description: description,
                      userId: userId,
                      avatarUrl: avatarUrl,
                      tag: tag,
                    ),
                  ),

                  bottom: TabBar(
                    indicatorColor: Colors.white54,
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              UserBookPage(bookJson: bookJson),
              UserGroupPage(groupJson: groupJson),
              FollowingPage(followingJson: followingJson),
              FollowerPage(followerJson: followsJson),
            ],
          ),
        ),
      ),
    );
  }
}
