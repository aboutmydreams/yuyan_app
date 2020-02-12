import 'package:flutter/material.dart';
import 'package:yuyan_app/models/component/appUI.dart';
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

class _GroupPageState extends State<GroupPage> {
  _GroupPageState({Key key, this.groupdata, this.pageIndex});
  final GroupData groupdata;
  final int pageIndex;
  @override
  Widget build(BuildContext context) {
    var _tabs = <String>[];
    _tabs = <String>[
      "首页",
      "知识库",
      "讨论区",
      "成员",
    ];
    print(pageIndex);

    return Scaffold(
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

                  expandedHeight: 460.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  stretchTriggerOffset: 10,
                  elevation: 10,
                  //是否显示阴影，直接取值innerBoxIsScrolled，展开不显示阴影，合并后会显示
                  forceElevated: innerBoxIsScrolled,

                  actions: <Widget>[
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
                          top: 100,
                          left: 30,
                          child: Hero(
                            tag: groupdata.id,
                            child: userAvatar(groupdata.avatarUrl, height: 80),
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
            // These are the contents of the tab views, below the tabs.
            children: [
              SafeArea(
                top: false,
                bottom: false,
                child: CustomScrollView(
                  slivers: <Widget>[
                    // SliverOverlapInjector(
                    //   handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    //       context),
                    // ),
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
                ),
              ),
              SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      // key: PageStorageKey<String>(name),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
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
              ),
              CustomScrollView(
                slivers: [
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
              ),
              SelectionPage(),
            ],
          ),
        ),
      ),
    );
  }
}
