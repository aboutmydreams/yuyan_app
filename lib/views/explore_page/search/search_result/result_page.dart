import 'package:flutter/material.dart';
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
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          toolbarOpacity: 1.0,
          bottomOpacity: 5.0,
          elevation: 0.0,
          title: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white.withOpacity(0.95),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3.0,
            tabs: <Widget>[
              Tab(
                text: "关注",
              ),
              Tab(
                text: "精选",
              ),
              Tab(
                text: "关注2",
              ),
              Tab(
                text: "精选2",
              ),
            ],
          ),
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
          ],
        ),
      ),
    );
  }
}
