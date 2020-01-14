import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/tools/write_json.dart';

import 'data/news_data.dart';

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

  saveSelecData() async {
    var countData = await DioReq.get("/notifications/unread-count");
    var unreadData = await DioReq.get("/notifications?offset=0&type=unread");
    var readedData = await DioReq.get("/notifications?offset=0&type=readed");
    await writeJson('unread_count', countData["data"]);
    await writeJson('unread_data', unreadData["data"]);
    await writeJson('readed_data', readedData["data"]);
    return 1;
  }

  void update() {
    saveSelecData().then((res) {
      getSaveData();
    });
  }
}
