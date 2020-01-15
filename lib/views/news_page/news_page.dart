import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/state_manage/dataManage/data/news_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/news_page/view/news_count.dart';
import 'package:yuyan_app/views/news_page/view/one_news/one_news.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  ScrollController _controller;
  List<Notifications> allNewsList = [];
  // Unread newsCount = topModel.newsManage.newsCount;
  // List<Notifications> unreadList = topModel.newsManage.unreadNews.notifications;
  // List<Notifications> readedList = topModel.newsManage.readedNews.notifications;
  Unread newsCount;
  int count;
  List<Notifications> unreadList;
  List<Notifications> readedList;
  @override
  void initState() {
    super.initState();
    newsCount = topModel.newsManage.newsCount;
    unreadList = topModel.newsManage.unreadNews.notifications;
    readedList = topModel.newsManage.readedNews.notifications;
    count = newsCount.count;

    _controller = ScrollController();
    allNewsList.addAll(unreadList);
    allNewsList.addAll(readedList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("全部消息"),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: newsCountView(context, count),
          ),
          Positioned(
            top: 39,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 100,
              child: RefreshIndicator(
                onRefresh: () async {
                  allNewsList.clear();
                  // allNewsList
                  topModel.newsManage.update();
                  await Future.delayed(const Duration(seconds: 1)).then((nul) {
                    setState(() {
                      newsCount = topModel.newsManage.newsCount;
                      unreadList = topModel.newsManage.unreadNews.notifications;
                      readedList = topModel.newsManage.readedNews.notifications;
                      count = newsCount.count;
                      print(count);
                      allNewsList.clear();
                      allNewsList.addAll(unreadList);
                      allNewsList.addAll(readedList);
                    });
                  });
                },
                child: ListView.builder(
                  controller: _controller,
                  itemCount: allNewsList.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    // return Text("data");
                    if (index < unreadList.length) {
                      return OneNewsContainer(
                          data: allNewsList[index], unread: true);
                    } else {
                      if (index == allNewsList.length) {
                        return SizedBox(height: 100);
                      } else {
                        return OneNewsContainer(
                            data: allNewsList[index], unread: false);
                      }
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
