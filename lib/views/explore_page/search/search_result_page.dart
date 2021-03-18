import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';
import 'package:yuyan_app/config/viewstate/view_page.dart';
import 'package:yuyan_app/controller/global/search_controller.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/document/group.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/model/topic/topic.dart';
import 'package:yuyan_app/models/net/requests_api/search/data/doc_data.dart';
import 'package:yuyan_app/models/net/requests_api/search/data/group_data.dart';
import 'package:yuyan_app/models/net/requests_api/search/data/repos_data.dart';
import 'package:yuyan_app/models/net/requests_api/search/data/topic_data.dart';
import 'package:yuyan_app/models/net/requests_api/search/data/user_data.dart';
import 'package:yuyan_app/models/net/requests_api/search/search.dart';
import 'package:yuyan_app/views/explore_page/search/search_result/view/search_doc.dart';
import 'package:yuyan_app/views/explore_page/search/search_result/view/search_group.dart';
import 'package:yuyan_app/views/explore_page/search/search_result/view/search_repos.dart';
import 'package:yuyan_app/views/explore_page/search/search_result/view/search_topic.dart';
import 'package:yuyan_app/views/explore_page/search/search_result/view/search_user.dart';
import 'package:yuyan_app/views/explore_page/widget/book_tile_widget.dart';
import 'package:yuyan_app/views/explore_page/widget/doc_tile_widget.dart';
import 'package:yuyan_app/views/widget/group_row_widget.dart';
import 'package:yuyan_app/views/widget/topic_item_widget.dart';
import 'package:yuyan_app/views/widget/user_widget.dart';

class SearchResultWidget extends StatefulWidget {
  final String query;
  final int initIndex;

  const SearchResultWidget({
    Key key,
    this.query,
    this.initIndex = 0,
  }) : super(key: key);

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget>
    with SingleTickerProviderStateMixin {
  final Map tabs = {
    'doc': '文档',
    'book': '知识库',
    'topic': '讨论',
    'group': '团队',
    'user': '用户',
  };
  final Map tabIcons = {
    "doc": Icons.description,
    "book": Icons.book,
    "topic": Icons.comment,
    "group": Icons.supervised_user_circle,
    "user": Icons.person,
  };

  List<ShiftingTab> _buildTabs() {
    return tabs.keys.map((e) {
      return ShiftingTab(
        icon: Icon(
          tabIcons[e],
        ),
        text: tabs[e],
      );
    }).toList();
  }

  TabController _tabController;

  initState() {
    super.initState();

    /// doc, book , topic, group, user,
    /// attachment, resource, note, content, edison
    var query = widget.query;
    tabs.keys.forEach((type) {
      Get.lazyPut(
        () => SearchController(
          type: type,
        )..doSearch(query),
        tag: '$type+$query',
      );
    });

    _tabController = TabController(
      initialIndex: widget.initIndex,
      length: tabIcons.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShiftingTabBar(
        color: Theme.of(context).scaffoldBackgroundColor,
        controller: _tabController,
        tabs: _buildTabs(),
      ),
      body: Container(
        child: TabBarView(
          controller: _tabController,
          children: _buildTabView(),
        ),
      ),
    );
  }

  List<Widget> _buildTabView() {
    var query = widget.query;
    return [
      //文档
      GetBuilder<SearchController>(
        tag: 'doc+' + query,
        autoRemove: false,
        builder: (c) => c.stateBuilder(
          onIdle: () {
            var data = c.hits;
            return Scrollbar(
              child: SmartRefresher(
                controller: c.refreshController,
                onRefresh: c.refreshCallback,
                onLoading: c.loadMoreCallback,
                enablePullUp: true,
                child: ListView.builder(
                  key: PageStorageKey('doc'),
                  itemCount: data.length,
                  itemBuilder: (_, i) {
                    var item = data[i].record.serialize<DocSeri>();
                    return DocTileWidget(item: item);
                  },
                ),
              ),
            );
          },
        ),
      ),
      //知识库
      FetchRefreshListViewBuilder<SearchController>(
        tag: 'book+' + query,
        builder: (c) {
          var data = c.hits;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, i) {
              var item = data[i].record.serialize<BookSeri>();
              return BookTileWidget(item: item);
            },
          );
        },
      ),
      //话题
      FetchRefreshListViewBuilder<SearchController>(
        tag: 'topic+' + query,
        builder: (c) {
          var data = c.hits;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, i) {
              var item = data[i].record.serialize<TopicSeri>();
              return TopicRowItemWidget(data: item);
            },
          );
        },
      ),
      //组织
      FetchRefreshListViewBuilder<SearchController>(
        tag: 'group+' + query,
        builder: (c) {
          var data = c.hits;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, i) {
              var item = data[i].record.serialize<GroupSeri>();
              return GroupRowItemWidget(group: item);
            },
          );
        },
      ),
      //用户
      FetchRefreshListViewBuilder<SearchController>(
        tag: 'user+' + query,
        builder: (c) {
          var data = c.hits;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, i) {
              var item = data[i].record.serialize<UserSeri>();
              return UserTileWidget(user: item);
            },
          );
        },
      ),
    ];
  }
}
//
// class SearchResultPage extends StatefulWidget {
//   SearchResultPage({Key key, this.text, this.aboutMe, this.pageIndex})
//       : super(key: key);
//   final String text;
//   final bool aboutMe;
//   final int pageIndex;
//
//   @override
//   _SearchResultPageState createState() => _SearchResultPageState(
//       text: text, aboutMe: aboutMe, pageIndex: pageIndex);
// }
//
// class _SearchResultPageState extends State<SearchResultPage>
//     with SingleTickerProviderStateMixin {
//   _SearchResultPageState({Key key, this.text, this.aboutMe, this.pageIndex});
//
//   final String text;
//   final bool aboutMe;
//   int pageIndex;
//
//   TabController _tabController;
//   SearchDocJson searchDocJson;
//   SearchUserJson searchUserJson;
//   SearchGroupJson searchGroupJson;
//   SearchReposJson searchReposJson;
//   SearchTopicJson searchTopicJson;
//
//   @override
//   void initState() {
//     super.initState();
//
//     getAboutAllData();
//     _tabController = TabController(
//       vsync: this,
//       initialIndex: pageIndex,
//       length: 5, //searchAll.keys.length,
//     )..addListener(() => changeIndex(_tabController.index));
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
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
//   getAboutAllData() async {
//     if (aboutMe) {
//       SearchDocJson docData =
//           await DioSearch.getDoc(text: text, aboutMe: true, page: 1);
//       SearchReposJson reposData =
//           await DioSearch.getRepos(text: text, aboutMe: true, page: 1);
//       SearchTopicJson topicData =
//           await DioSearch.getTopic(text: text, aboutMe: true, page: 1);
//       setState(() {
//         searchDocJson = docData;
//         searchReposJson = reposData;
//         searchTopicJson = topicData;
//       });
//     } else {
//       SearchDocJson docData = await DioSearch.getDoc(text: text, page: 1);
//       SearchUserJson userData = await DioSearch.getUser(text: text, page: 1);
//       SearchGroupJson groupData = await DioSearch.getGroup(text: text, page: 1);
//       SearchReposJson reposData = await DioSearch.getRepos(text: text, page: 1);
//       SearchTopicJson topicData = await DioSearch.getTopic(text: text, page: 1);
//       setState(() {
//         searchDocJson = docData;
//         searchUserJson = userData;
//         searchGroupJson = groupData;
//         searchReposJson = reposData;
//         searchTopicJson = topicData;
//       });
//     }
//   }
//
//   Widget searchResult(String k) {
//     Map<String, Widget> searchResultMap = {
//       "文档": SearchDocPage(docBookJson: searchDocJson),
//       "知识库": SearchReposPage(searchReposJson: searchReposJson),
//       "讨论": SearchTopicPage(searchTopicJson: searchTopicJson),
//       "团队": SearchGroupPage(searchGroupJson: searchGroupJson),
//       "用户": SearchUserPage(searchUserJson: searchUserJson),
//     };
//     return searchResultMap[k];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Map searchMap = aboutMe ? searchMe : searchAll;
//     return Scaffold(
//         // appBar: ShiftingTabBar(
//         //   color: Colors.white,
//         //   brightness: Brightness.light,
//         //   controller: _tabController,
//         // tabs: searchMap.keys
//         //     .map((k) => ShiftingTab(text: k, icon: Icon(searchMap[k])))
//         //     .toList(),
//         // ),
//         // body: TabBarView(
//         //   controller: _tabController,
//         //   children:
//         //       searchMap.keys.map((element) => searchResult(element)).toList(),
//         // ),
//         );
//   }
// }
