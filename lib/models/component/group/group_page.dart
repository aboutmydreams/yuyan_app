import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/component/group/view/book_page.dart';
import 'package:yuyan_app/models/component/group/view/member_page.dart';
import 'package:yuyan_app/models/component/group/view/topic_page.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_book_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_member_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_topic_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/group.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/user_avatar.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';
import 'package:yuyan_app/views/explore_page/selection/selection_page.dart';

class GroupPage extends StatefulWidget {
  GroupPage({Key key, this.groupdata, this.pageIndex}) : super(key: key);
  final GroupData groupdata;
  final pageIndex;

  @override
  _GroupPageState createState() =>
      _GroupPageState(groupdata: groupdata, pageIndex: pageIndex);
}

class _GroupPageState extends State<GroupPage>
    with SingleTickerProviderStateMixin {
  _GroupPageState({Key key, this.groupdata, this.pageIndex});
  final GroupData groupdata;

  int pageIndex;
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

  @override
  void initState() {
    super.initState();
    getBook();
    getTopic();
    getMember();
    _tabController = TabController(vsync: this, length: 4)
      ..addListener(() {
        changeIndex(_tabController.index);
      });
  }

  changeIndex(int index) {
    setState(() {
      pageIndex = index;
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
        length: _tabs.length, // This is the number of tabs.
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
                    new IconButton(
                      icon: Icon(Icons.star_border), //Icon(Icons.star)
                      onPressed: () {
                        print("更多");
                      },
                    ),
                    new IconButton(
                      icon: Icon(Icons.more_horiz),
                      onPressed: () {
                        print("更多");
                      },
                    ),
                  ],

                  flexibleSpace: new FlexibleSpaceBar(
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
              Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(10.0),
                        sliver: SliverFixedExtentList(
                          itemExtent: 50.0, //item高度或宽度，取决于滑动方向
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return ListTile(
                                title: Text('Item $index'),
                              );
                            },
                            childCount: 30,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Builder(
                builder: (BuildContext context) {
                  return BookPage(
                    bookJson: bookJson,
                  );
                },
              ),
              Builder(
                builder: (BuildContext context) {
                  return TopicPage(
                    topicJson: topicJson,
                  );
                },
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
