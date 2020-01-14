import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/component/appUI.dart';
import 'package:yuyan_app/state_manage/dataManage/data/news_data.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/views/news_page/view/news_count.dart';
import 'package:yuyan_app/views/news_page/view/one_new.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TopStateModel>(
      builder: (context, child, model) {
        // List<Notification> attentDatas = model.newsManage.;
        Unread newsCount = model.newsManage.newsCount;
        List<Notifications> unreadList =
            model.newsManage.unreadNews.notifications;
        print(unreadList);

        return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              title: Text("全部消息"),
            ),
            body: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  child: newsCountView(context, newsCount.count),
                ),
                Positioned(
                  top: 39,
                  child: SingleChildScrollView(
                    child: Column(
                      children: unreadList
                          .map((res) => oneNew(context, res))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
