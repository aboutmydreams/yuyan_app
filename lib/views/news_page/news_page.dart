import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/models/widgets_big/change_org/org_leading.dart';
import 'package:yuyan_app/models/widgets_small/list_animation.dart';
import 'package:yuyan_app/models/widgets_small/toast.dart';
import 'package:yuyan_app/state_manage/dataManage/data/news_data.dart';
import 'package:yuyan_app/state_manage/dataManage/mydata_manage.dart';
import 'package:yuyan_app/state_manage/dataManage/news_manage.dart';
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
  List<Notifications> unreadList = topModel.newsManage.unreadNews.notifications;
  List<Notifications> readedList = topModel.newsManage.readedNews.notifications;

  @override
  void initState() {
    super.initState();
    if (unreadList != null) {
      count = unreadList.length;
    }
  }

  // 下拉刷新函数
  Future onfresh() async {
    topModel.newsManage.update();
    await Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        setState(() {
          unreadList = topModel.newsManage.unreadNews.notifications;
          readedList = topModel.newsManage.readedNews.notifications;
          if (unreadList != null) {
            myToast(context, "已更新");
          } else {
            myToast(context, "稍后试一试");
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
        leading: ScopedModel<MyInfoManage>(
          model: topModel.myInfoManage,
          child: OrgLeading(),
        ),
        title: Text("全部消息"),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: newsCountView(context),
          ),
          Positioned(
            top: 39,
            child: ScopedModelDescendant<NewsManage>(
              builder: (context, child, model) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 80,
                  child: RefreshIndicator(
                    onRefresh: onfresh,
                    child: AnimationLimiter(
                      child: ListView.builder(
                        controller: _controller,
                        itemCount: model.allNews.notifications.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          // 先展示未读消息列表，再显示最近已读消息列表
                          if (index < model.allNews.notifications.length) {
                            return animationChild(
                              index: index,
                              child: OneNewsContainer(
                                data: model.allNews.notifications[index],
                                unread:
                                    model.allNews.notifications[index].unread,
                              ),
                            );
                          } else {
                            return SizedBox(height: 150);
                          }
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
