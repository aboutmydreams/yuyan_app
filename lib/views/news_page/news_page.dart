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
  Unread newsCount = topModel.newsManage.newsCount;
  int count;
  List<Notifications> unreadList = topModel.newsManage.unreadNews.notifications;
  List<Notifications> readedList = topModel.newsManage.readedNews.notifications;
  // List<Notifications> unreadList = topModel.newsManage.unreadNews.notifications;
  // List<Notifications> readedList = topModel.newsManage.readedNews.notifications;
  @override
  void initState() {
    super.initState();
    count = topModel.newsManage.newsCount.count;
  }

  @override
  Widget build(BuildContext context) {
    print("unreadList==${unreadList.length}");
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
                  topModel.newsManage.update();

                  await Future.delayed(
                    const Duration(milliseconds: 1500),
                    () {
                      setState(() {
                        newsCount = topModel.newsManage.newsCount;
                        unreadList =
                            topModel.newsManage.unreadNews.notifications;
                        readedList =
                            topModel.newsManage.readedNews.notifications;
                        count = newsCount.count;
                      });
                    },
                  );
                },
                child: ListView.builder(
                  controller: _controller,
                  itemCount: unreadList.length + readedList.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < unreadList.length) {
                      return OneNewsContainer(
                        data: unreadList[index],
                        unread: true,
                      );
                    } else {
                      if (index >= unreadList.length + readedList.length) {
                        return SizedBox(height: 100);
                      } else {
                        return OneNewsContainer(
                          data: readedList[index - unreadList.length],
                          unread: false,
                        );
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
