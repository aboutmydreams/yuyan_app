import 'package:yuyan_app/config/net/api.dart';
import 'package:yuyan_app/model/dashboard/quick_link_seri.dart';
import 'package:yuyan_app/model/dashboard/user_recent_seri.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/serializer/events/event_seri.dart';
import 'package:yuyan_app/model/serializer/serializer.dart';

class ApiRepository {
  static BaseApi api = BaseApi();

  static Future<List<EventSeri>> getAttendEvents([int offset = 0]) async {
    var resp = await api.get('/events', queryParameters: {
      'offset': offset,
    });
    var asp = resp.data as ApiResponse;
    var data = (asp.data as List).map((e) => EventSeri.fromJson(e)).toList();
    return data;
  }

  static Future<List<DocSeri>> getExploreSelections([int limit = 4]) async {
    var resp = await api.get('/explore/selections?limit=$limit');
    var asp = resp.data as ApiResponse;
    var data = (asp.data as List).map((e) => DocSeri.fromJson(e)).toList();
    return data;
  }

  static Future<List<Serializer>> getExploreRecommends({
    int page = 0,
    int limit = 20,
    bool isDoc = false,
  }) async {
    if (isDoc) {
      var resp =
          await api.get('/explore/recommends?limit=$limit&page=$page&type=Doc');
      var asp = resp.data as ApiResponse;
      return (asp.data['docs'] as List)
          .map((e) => Serializer.fromJson(e))
          .toList();
    } else {
      List<Serializer> list = [];
      var resp = await api.get('/explore/recommends?limit=$limit');
      var asp = resp.data as ApiResponse;
      var data = asp.data;
      if (data['books'] != null) {
        list.addAll((data['books'] as List)
            .map((e) => Serializer.fromJson(e))
            .toList());
      }
      if (data['docs'] != null) {
        list.addAll(
            (data['docs'] as List).map((e) => Serializer.fromJson(e)).toList());
      }
      if (data['users'] != null) {
        list.addAll((data['users'] as List)
            .map((e) => Serializer.fromJson(e))
            .toList());
      }
      return list;
    }
  }

  static Future<List<UserRecentSeri>> getUserRecentList(
      {int limit = 100, int offset = 0}) async {
    var resp = await api.get(
      '/mine/recent_list',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    var asp = resp.data as ApiResponse;
    return (asp.data as List).map((e) => UserRecentSeri.fromJson(e)).toList();
  }

  static Future<List<QuickLinkSeri>> getUserQuickLinkList() async {
    var resp = await api.get('/quick_links');
    var asp = resp.data as ApiResponse;
    return (asp.data as List).map((e) => QuickLinkSeri.fromJson(e)).toList();
  }
}
