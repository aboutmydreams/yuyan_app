import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/tools/write_json.dart';

import 'data/news_data.dart';
import 'dart:io';

class NewsManage extends Model {
  int offset = 0;
  Unread _newsCount = Unread(count: 0);
  NewsData _unreadNews = NewsData(notifications: []);
  NewsData _readedNews = NewsData(notifications: []);
  Unread get newsCount => _newsCount;
  NewsData get unreadNews => _unreadNews;
  NewsData get readedNews => _readedNews;

  getSaveData() async {
    var newsCountData = await readJson('unread_count');
    var unreadData = await readJson('unread_data');
    var readedData = await readJson('readed_data');
    Unread newsCount = Unread.fromJson(newsCountData);
    NewsData unreadNews = NewsData.fromJson(unreadData);
    NewsData readedNews = NewsData.fromJson(readedData);
    _newsCount = newsCount;
    _unreadNews = unreadNews;
    _readedNews = readedNews;
    notifyListeners();
    return 1;
  }

  getMoreData() async {
    offset += 100;
    var dioData = await DioReq.get("/notifications?offset=$offset&type=readed");
    NewsData newsionsData = NewsData.fromJson(dioData);
    _readedNews.notifications.addAll(newsionsData.notifications);
    notifyListeners();
  }

  readAll() async {
    // var dioData =
    //     await DioReq.put("/notifications/unread-count", data: {"ids": "all"});
    // // if(newsCount.list!=null){}
    // if (dioData["data"].containsKey("ok")) {
    //   notifyListeners();
    // }

    for (int i = 0; i < _unreadNews.notifications.length; i++) {
      // _newsCount.count = _newsCount.count - 1;

      int longTime = 70 * i;
      Future.delayed(Duration(milliseconds: longTime), () {
        _newsCount.count -= 1;
        print(_newsCount.count);
        _readedNews.notifications.insert(0, _unreadNews.notifications[i]);
        _unreadNews.notifications.removeAt(i);
        notifyListeners();
      });
    }
  }

  saveNewsData() async {
    var countData = await DioReq.get("/notifications/unread-count");
    var unreadData = await DioReq.get("/notifications?offset=0&type=unread");
    var readedData = await DioReq.get("/notifications?offset=0&type=readed");
    await writeJson('unread_count', countData["data"]);
    await writeJson('unread_data', unreadData["data"]);
    await writeJson('readed_data', readedData["data"]);
    return 1;
  }

  void update() {
    saveNewsData().then((res) async {
      await getSaveData();
    });
  }
}
