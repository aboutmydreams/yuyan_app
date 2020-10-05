import 'package:flutter/material.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';
import 'package:yuyan_app/models/net/requests_api/search/data/doc_data.dart';
import 'package:yuyan_app/models/net/requests_api/search/search.dart';

class SearchResultPage extends StatefulWidget {
  SearchResultPage({Key key, this.text, this.aboutMe}) : super(key: key);
  final String text;
  final bool aboutMe;

  @override
  _SearchResultPageState createState() =>
      _SearchResultPageState(text: text, aboutMe: aboutMe);
}

class _SearchResultPageState extends State<SearchResultPage>
    with AutomaticKeepAliveClientMixin {
  _SearchResultPageState({Key key, this.text, this.aboutMe});
  final String text;
  final bool aboutMe;
  SearchDocJson searchDocJson;

  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    SearchDocJson docData = DioSearch.getDoc(text: text, page: 1);
    setState(() {
      searchDocJson = docData;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: ShiftingTabBar(
          color: Colors.white,
          brightness: Brightness.light,
          // brightness: Colors.black.withOpacity(0.95),
          // indicatorSize: TabBarIndicatorSize.label,
          // indicatorWeight: 3.0,
          tabs: [
            ShiftingTab(
              icon: Icon(Icons.directions_bike),
              text: "关注",
            ),
            ShiftingTab(
              icon: Icon(Icons.directions_bike),
              text: "关注1",
            ),
            ShiftingTab(
              icon: Icon(Icons.directions_bike),
              text: "精选",
            ),
            ShiftingTab(
              icon: Icon(Icons.directions_bike),
              text: "关注2",
            ),
            ShiftingTab(
              icon: Icon(Icons.directions_bike),
              text: "关注2",
            ),
            ShiftingTab(
              icon: Icon(Icons.directions_bike),
              text: "关注2",
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              child: Text("t1"),
            ),
            Container(
              child: Text("t2"),
            ),
            Container(
              child: Text("t2"),
            ),
            Container(
              child: Text("t2"),
            ),
            Container(
              child: Text("t2"),
            ),
            Container(
              child: Text("t2"),
            ),
          ],
        ),
      ),
    );
  }
}
