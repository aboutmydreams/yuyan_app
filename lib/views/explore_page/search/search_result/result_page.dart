import 'package:flutter/material.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';
import 'package:yuyan_app/models/net/requests_api/search/data/doc_data.dart';
import 'package:yuyan_app/models/net/requests_api/search/search.dart';
import 'package:yuyan_app/views/explore_page/search/search_result/view/search_doc.dart';
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

  @override
  void initState() {
    super.initState();
    getData();
    _tabController =
        TabController(vsync: this, initialIndex: pageIndex, length: 6)
          ..addListener(() => changeIndex(_tabController.index));
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

  getData() async {
    SearchDocJson docData = await DioSearch.getDoc(text: text, page: 1);
    setState(() {
      searchDocJson = docData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: ShiftingTabBar(
          color: Colors.white,
          brightness: Brightness.light,
          controller: _tabController,
          tabs: searchAll.keys
              .map((k) => ShiftingTab(text: k, icon: Icon(searchAll[k])))
              .toList(),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              child: SearchDocPage(docBookJson: searchDocJson),
            ),
            Container(
              child: Text("t2"),
            ),
            Container(
              child: Text("t3"),
            ),
            Container(
              child: Text("t4"),
            ),
            Container(
              child: Text("t5"),
            ),
            Container(
              child: Text("t6"),
            ),
          ],
        ),
      ),
    );
  }
}
