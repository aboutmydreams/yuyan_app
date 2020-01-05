import 'package:flutter/material.dart';
import 'package:yuyan_app/views/news_page/view/news_count.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("全部消息"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[newsCount()],
        ),
      ),
    );
  }
}
