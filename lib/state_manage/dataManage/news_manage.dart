import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/tools/write_json.dart';

import 'data/news_data.dart';

class NewsManage extends Model {
  int offset = 0;
  Unread _newsCount = Unread(count: 0);
  NewsData _allNews = NewsData(notifications: []);
  NewsData _unreadNews = NewsData(notifications: []);
  NewsData _readedNews = NewsData(notifications: []);
  Unread get newsCount => _newsCount;
  NewsData get allNews => _allNews;
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

    for (Notifications oneData in unreadNews.notifications) {
      oneData.unread = true;
    }
    for (Notifications oneData in readedNews.notifications) {
      oneData.unread = false;
    }
    _allNews = NewsData(notifications: []);
    _allNews.notifications.addAll(unreadNews.notifications);
    _allNews.notifications.addAll(readedNews.notifications);

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
    var dioData = await DioReq.put("/notifications", data: {"ids": "all"});

    // if (dioData["data"].containsKey("ok")) {
    //   notifyListeners();
    // }

    for (int i = 0; i < _unreadNews.notifications.length; i++) {
      // _newsCount.count = _newsCount.count - 1;
      int longTime = 80 * i;
      Future.delayed(Duration(milliseconds: longTime), () {
        if (_newsCount.count > 0) {
          _newsCount.count -= 1;
        } else {
          _newsCount.count = 0;
        }
        _allNews.notifications[i].unread = false;
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
