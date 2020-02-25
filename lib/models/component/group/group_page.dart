import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/group/all_topic/topic_page.dart';
import 'package:yuyan_app/models/component/group/view/book_page.dart';
import 'package:yuyan_app/models/component/group/view/home_page.dart';
import 'package:yuyan_app/models/component/group/view/member_page.dart';
import 'package:yuyan_app/models/component/group/view/topic_page.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_book_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_home_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_member_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_topic_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/group.dart';
import 'package:yuyan_app/models/net/requests_api/user/user.dart';
import 'package:yuyan_app/models/widgets_small/menu_item.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';

class GroupPage extends StatefulWidget {
  GroupPage({Key key, this.groupdata, this.pageIndex}) : super(key: key);
  final GroupData groupdata;
  final int pageIndex;

  @override
  _GroupPageState createState() =>
      _GroupPageState(groupdata: groupdata, pageIndex: pageIndex);
}

class _GroupPageState extends State<GroupPage>
    with SingleTickerProviderStateMixin {
  _GroupPageState({Key key, this.groupdata, this.pageIndex});
  final GroupData groupdata;

  int pageIndex;
  bool ifMark = false;
  TabController _tabController;

  List<String> _tabs = [
    "首页",
    "知识库",
    "讨论区",
    "成员",
  ];

  MemberJson memberJson;
  GroupTopicJson topicJson;
  GroupBookJson bookJson;
  GroupHomeJson homeJson;

  @override
  void initState() {
    super.initState();
    getIfMark();
    getHome();
    getBook();
    getTopic();
    getMember();
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

  getIfMark() async {
    bool ifMarkIt =
        await DioUser.ifMark(targetType: "User", targetId: groupdata.id);
    setState(() {
      ifMark = ifMarkIt;
    });
  }

  changeMark() async {
    setState(() {
      ifMark = !ifMark;
    });
    if (ifMark) {
      var ans =
          await DioUser.cancelMark(targetType: "User", targetId: groupdata.id);
      print(ans);
    } else {
      var ans = await DioUser.mark(targetType: "User", targetId: groupdata.id);
      print(ans);
    }
  }

  getHome() async {
    GroupHomeJson home = await DioGroup.getHomeData(groupId: groupdata.id);
    setState(() {
      homeJson = home;
    });
  }

  getBook() async {
    GroupBookJson book = await DioGroup.getBookData(groupId: groupdata.id);
    setState(() {
      bookJson = book;
    });
  }

  getTopic() async {
    GroupTopicJson topic = await DioGroup.getTopicData(groupId: groupdata.id);
    setState(() {
      topicJson = topic;
    });
  }

  getMember() async {
    MemberJson member = await DioGroup.getMemberData(groupId: groupdata.id);
    setState(() {
      memberJson = member;
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
          onPressed: () {},
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
                  title: Text('${groupdata.name}'),
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
                      icon: ifMark ? Icon(Icons.star) : Icon(Icons.star_border),
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
                                groupId: groupdata.id,
                                openTopicJson: topicJson,
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
                                  "${groupdata.description ?? '暂无介绍'}",
                                  style: AppStyles.groupTextStyle,
                                  maxLines: 4,
                                ),
                              ),
                              Spacer(),
                              Hero(
                                tag: groupdata.id,
                                child:
                                    userAvatar(groupdata.avatarUrl, height: 60),
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
              GroupHome(
                homeJson: homeJson,
              ),
              BookPage(
                bookJson: bookJson,
              ),
              TopicPage(
                topicJson: topicJson,
                groupId: groupdata.id,
              ),
              Builder(
                builder: (BuildContext context) {
                  return MemberPage(
                    memberJson: memberJson,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
