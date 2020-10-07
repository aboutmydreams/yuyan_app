import 'package:flutter/material.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';
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
import 'package:yuyan_app/views/explore_page/search/tabbar_config.dart';

class SearchResultPage extends StatefulWidget {
  SearchResultPage({Key key, this.text, this.aboutMe, this.pageIndex})
      : super(key: key);
  final String text;
  final bool aboutMe;
  final int pageIndex;

  @override
  _SearchResultPageState createState() => _SearchResultPageState(
      text: text, aboutMe: aboutMe, pageIndex: pageIndex);
}

class _SearchResultPageState extends State<SearchResultPage>
    with SingleTickerProviderStateMixin {
  _SearchResultPageState({Key key, this.text, this.aboutMe, this.pageIndex});
  final String text;
  final bool aboutMe;
  int pageIndex;

  TabController _tabController;
  SearchDocJson searchDocJson;
  SearchUserJson searchUserJson;
  SearchGroupJson searchGroupJson;
  SearchReposJson searchReposJson;
  SearchTopicJson searchTopicJson;

  @override
  void initState() {
    super.initState();

    getAboutAllData();
    _tabController = TabController(
      vsync: this,
      initialIndex: pageIndex,
      length: aboutMe ? searchMe.keys.length : searchAll.keys.length,
    )..addListener(() => changeIndex(_tabController.index));
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

  getAboutAllData() async {
    if (aboutMe) {
      SearchDocJson docData =
          await DioSearch.getDoc(text: text, aboutMe: true, page: 1);
      SearchReposJson reposData =
          await DioSearch.getRepos(text: text, aboutMe: true, page: 1);
      SearchTopicJson topicData =
          await DioSearch.getTopic(text: text, aboutMe: true, page: 1);
      setState(() {
        searchDocJson = docData;
        searchReposJson = reposData;
        searchTopicJson = topicData;
      });
    } else {
      SearchDocJson docData = await DioSearch.getDoc(text: text, page: 1);
      SearchUserJson userData = await DioSearch.getUser(text: text, page: 1);
      SearchGroupJson groupData = await DioSearch.getGroup(text: text, page: 1);
      SearchReposJson reposData = await DioSearch.getRepos(text: text, page: 1);
      SearchTopicJson topicData = await DioSearch.getTopic(text: text, page: 1);
      setState(() {
        searchDocJson = docData;
        searchUserJson = userData;
        searchGroupJson = groupData;
        searchReposJson = reposData;
        searchTopicJson = topicData;
      });
    }
  }

  Widget searchResult(String k) {
    Map<String, Widget> searchResultMap = {
      "文档": SearchDocPage(docBookJson: searchDocJson),
      "知识库": SearchReposPage(searchReposJson: searchReposJson),
      "讨论": SearchTopicPage(searchTopicJson: searchTopicJson),
      "团队": SearchGroupPage(searchGroupJson: searchGroupJson),
      "用户": SearchUserPage(searchUserJson: searchUserJson),
    };
    return searchResultMap[k];
  }

  @override
  Widget build(BuildContext context) {
    Map searchMap = aboutMe ? searchMe : searchAll;
    return DefaultTabController(
      length: searchMap.keys.length,
      child: Scaffold(
        appBar: ShiftingTabBar(
          color: Colors.white,
          brightness: Brightness.light,
          controller: _tabController,
          tabs: searchMap.keys
              .map((k) => ShiftingTab(text: k, icon: Icon(searchMap[k])))
              .toList(),
        ),
        body: TabBarView(
          controller: _tabController,
          children:
              searchMap.keys.map((element) => searchResult(element)).toList(),
        ),
      ),
    );
  }
}
