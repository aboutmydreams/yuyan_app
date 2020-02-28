import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/user/view/book_page.dart';
import 'package:yuyan_app/models/component/user/view/follower_page.dart';
import 'package:yuyan_app/models/component/user/view/groups_page.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_follow_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_profile_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_repos_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/user.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';

class UserPage extends StatefulWidget {
  UserPage(
      {Key key,
      this.login,
      this.name,
      this.userId,
      this.avatarUrl,
      this.description,
      this.pageIndex})
      : super(key: key);
  final String login;
  final int userId;
  final String name;
  final String avatarUrl;
  final String description;
  final int pageIndex;

  @override
  _UserPageState createState() => _UserPageState(
        login: login,
        name: name,
        userId: userId,
        avatarUrl: avatarUrl,
        description: description,
        pageIndex: pageIndex,
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
      this.pageIndex});
  String login;
  int userId;
  String name;
  String description;
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
  UserBookJson bookJson;
  GroupJson groupJson;
  Follows followsJson;

  @override
  void initState() {
    super.initState();
    getFollower();
    getBook();
    getGroup();
  }

  changeIndex(int index) {
    if (mounted) {
      setState(() {
        pageIndex = index;
      });
    }
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
      var ans = await DioUser.cancelFollow(userId);
      print(ans);
    } else {
      var ans = await DioUser.followUser(userId);
      print(ans);
    }
  }

  getProfile() async {
    ProfileData profileData = await DioUser.getProfileData(userId);
    setState(() {
      profileJson = profileData;
    });
  }

  getBook() async {
    UserBookJson book = await DioUser.getReposData(login);
    setState(() {
      bookJson = book;
    });
  }

  getGroup() async {
    GroupJson groupData = await DioUser.getGroupData(userId);
    setState(() {
      groupJson = groupData;
    });
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
                child: SliverAppBar(
                  leading: new IconButton(
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
                    background: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Container(
                            // height: 230,
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              "assets/images/first.jpg",
                              color: Colors.black45,
                              colorBlendMode: BlendMode.darken,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 72,
                          top: 125,
                          right: 38,
                          child: Row(
                            children: [
                              Container(
                                width: 170,
                                child: Text(
                                  "${description ?? '这人很懒，签名也没有'}",
                                  style: AppStyles.groupTextStyle,
                                  maxLines: 4,
                                ),
                              ),
                              Spacer(),
                              Hero(
                                tag: userId,
                                child: userAvatar(avatarUrl, height: 60),
                              ),
                            ],
                          ),
                        ),
                      ],
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
              FollowerPage(followerJson: followsJson),
              Container(
                width: 300,
                height: 400,
                child: Text("data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
