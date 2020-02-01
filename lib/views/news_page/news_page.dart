import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
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
  int count;
  ScrollController _controller;
  Unread newsCount = topModel.newsManage.newsCount;
  List<Notifications> unreadList = topModel.newsManage.unreadNews.notifications;
  List<Notifications> readedList = topModel.newsManage.readedNews.notifications;

  @override
  void initState() {
    super.initState();
    if (newsCount.list != null) {
      for (UnreadNewsList news in newsCount.list) {
        if (news.isSelf == true) {
          count = news.count;
        }
      }
    }
  }

  // 下拉刷新函数
  Future onfresh() async {
    topModel.newsManage.update();
    await Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        setState(() {
          newsCount = topModel.newsManage.newsCount;
          unreadList = topModel.newsManage.unreadNews.notifications;
          readedList = topModel.newsManage.readedNews.notifications;
          if (newsCount.list != null) {
            for (UnreadNewsList news in newsCount.list) {
              if (news.isSelf == true) {
                count = news.count;
                myToast(context, "已更新");
              }
            }
          } else {
            count = newsCount.count;
          }
        });
      },
    );
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
                onRefresh: onfresh,
                child: AnimationLimiter(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: unreadList.length + readedList.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      // 先展示未读消息列表，再显示最近已读消息列表
                      if (index < unreadList.length) {
                        return animationChild(
                          index: index,
                          child: OneNewsContainer(
                            data: unreadList[index],
                            unread: true,
                          ),
                        );
                      } else {
                        if (index >= unreadList.length + readedList.length) {
                          return SizedBox(height: 100);
                        } else {
                          return animationChild(
                            index: index,
                            child: OneNewsContainer(
                              data: readedList[index - unreadList.length],
                              unread: false,
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
