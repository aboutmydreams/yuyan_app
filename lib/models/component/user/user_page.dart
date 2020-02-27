import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/group/all_topic/topic_page.dart';
import 'package:yuyan_app/models/component/group/topic/add_topic/add_topic.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_profile_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_repos_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/user.dart';
import 'package:yuyan_app/models/widgets_small/menu_item.dart';
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
  final String login;
  final int userId;
  final String name;
  final String description;
  final String avatarUrl;

  int pageIndex;
  bool isFollow = false;
  TabController _tabController;

  List<String> _tabs = [
    "知识库",
    "团队",
    "关注了",
    "关注者",
  ];

  ProfileData profileJson;
  UserBookJson bookJson;
  Group groupJson;

  @override
  void initState() {
    super.initState();
    getFollower();
    getBook();
    getGroup();
    _tabController =
        TabController(vsync: this, initialIndex: pageIndex, length: 4)
          ..addListener(() {
            print(_tabController.index);
            changeIndex(_tabController.index);
          });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  changeIndex(int index) {
    if (mounted) {
      setState(() {
        pageIndex = index;
      });
    }
  }

  getFollower() async {
    bool isFollowIt = await DioUser.getFollowerData(userId: userId);
    setState(() {
      isFollow = isFollowIt;
    });
  }

  changeMark() async {
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
    Group groupData = await DioUser.getGroupData(userId);
    setState(() {
      groupJson = groupData;
    });
  }

  floatingActionButton(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        return FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return AddTopicPage(groupId: userId);
            }));
          },
          child: Icon(Icons.add_comment),
        );
      case 3:
        // print(4);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(pageIndex),
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
                        changeMark();
                      },
                    ),
                    PopupMenuButton(
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuItem<String>>[
                        menuItem("A", "查看所有话题"),
                        menuItem("B", "打开网页版"),
                      ],
                      onSelected: (String action) {
                        // 点击选项的时候
                        switch (action) {
                          case 'A':
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return AllTopicPage(
                                groupId: userId,
                                // openTopicJson: topicJson,
                              );
                            }));
                            break;
                          case 'B':
                            break;
                          case 'C':
                            break;
                        }
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
                                  "${description ?? '暂����介绍'}",
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
                    controller: _tabController,
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              Container(
                width: 300,
                height: 400,
                child: Text("data"),
              ),
              Container(
                width: 300,
                height: 400,
                child: Text("data"),
              ),
              Container(
                width: 300,
                height: 400,
                child: Text("data"),
              ),
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
