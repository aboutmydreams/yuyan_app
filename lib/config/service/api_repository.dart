import 'package:flutter/cupertino.dart';
import 'package:yuyan_app/config/app.dart';
import 'package:yuyan_app/config/net/api.dart';
import 'package:yuyan_app/model/dashboard/quick_link_seri.dart';
import 'package:yuyan_app/model/dashboard/user_recent_seri.dart';
import 'package:yuyan_app/model/document/action.dart';
import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/document/group.dart';
import 'package:yuyan_app/model/document/organization_lite.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/model/document/user_profile.dart';
import 'package:yuyan_app/model/events/event_seri.dart';
import 'package:yuyan_app/model/notification/notification.dart';
import 'package:yuyan_app/model/notification/notification_item.dart';
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

  static Future<List<NotificationItemSeri>> getNotificationList(
      {String type = 'readed', int offset = 0, int limit = 100}) async {
    var resp = await api.get(
      '/notifications',
      queryParameters: {'type': type, 'offset': offset, 'limit': limit},
    );
    var asp = resp.data as ApiResponse;
    return NotificationSeri.fromJson(asp.data).notifications;
  }

  static Future<List<OrganizationLiteSeri>> getOrganizationList(
      {int userId}) async {
    var resp = await api.get('/users/$userId/organizations');
    var asp = resp.data as ApiResponse;
    var list = (asp.data as List)
        .map((e) => OrganizationLiteSeri.fromJson(e))
        .toList();
    return list;
  }

  static Future<UserProfileSeri> getUserProfile({int userId}) async {
    userId ??= App.user.data.id;
    var res = await api.get("/users/$userId/profile");
    var asp = (res.data as ApiResponse);
    return UserProfileSeri.fromJson(asp.data);
  }

  static Future<List<GroupSeri>> getGroupList({int userId}) async {
    userId ??= App.user.data.id;
    var res = await api.get("/users/$userId/groups");
    var asp = (res.data as ApiResponse);
    var list = (asp.data as List).map((e) => GroupSeri.fromJson(e)).toList();
    return list;
  }

  static Future<List<BookSeri>> getBookList({int userId}) async {
    var res = await api.get(
      "/groups/$userId/books?archived=include&limit=200",
    );
    var asp = res.data as ApiResponse;
    var list = (asp.data as List).map((e) => BookSeri.fromJson(e)).toList();
    return list;
  }

  static Future<bool> getIfFollow({int userId}) async {
    var res = await api.get(
      "/actions/user-owned",
      queryParameters: {
        "action_type": "follow",
        "target_ids": userId,
        "target_type": "User",
      },
    );
    var asp = res.data as ApiResponse;
    return (asp.data as List).length > 0;
  }

  static Future<List<UserSeri>> getFollowingList({
    int userId,
    int offset = 0,
  }) async {
    var res = await api.get(
      "/actions/targets",
      queryParameters: {
        "action_type": "follow",
        "target_type": "User",
        "user_id": userId,
        "offset": offset,
      },
    );
    var asp = res.data as ApiResponse;
    return (asp.data as List).map((e) => UserSeri.fromJson(e)).toList();
  }

  static Future<List<UserSeri>> getFollowerList({
    int userId,
    int offset = 0,
  }) async {
    var res = await api.get(
      "/actions/users",
      queryParameters: {
        "action_type": "follow",
        "target_type": "User",
        "target_id": userId,
        "offset": offset,
      },
    );
    var asp = res.data as ApiResponse;
    return (asp.data as List).map((e) => UserSeri.fromJson(e)).toList();
  }

  static Future<bool> followUser({int userId}) async {
    var res = await api.post("/actions", data: {
      "action_type": "follow",
      "target_type": "User",
      "target_id": userId,
    });
    var asp = res.data as ApiResponse;
    var data = ActionSeri.fromJson(asp.data);
    return data.targetId == userId;
  }

  static Future<bool> unfollowUser({int userId}) async {
    var res = await api.delete("/actions", data: {
      "action_type": "follow",
      "target_type": "User",
      "target_id": userId,
    });
    var asp = res.data as ApiResponse;
    return asp.data == null;
  }

  //我的关注知识库
  static Future<List<ActionSeri>> getFollowBookList({
    int limit = 100,
    int offset = 0,
  }) async {
    var res = await api.get(
      "/mine/follows",
      queryParameters: {
        "limit": limit,
        "offset": offset,
        "type": "Book",
      },
    );
    var asp = res.data as ApiResponse;
    var list = (asp.data as List).map((e) => ActionSeri.fromJson(e)).toList();
    return list;
  }

  static Future getMyBooks({int limit, int offset}) async {
    var res = await api.get(
      "/mine/follows",
      queryParameters: {
        "limit": limit,
        "offset": offset,
        "type": "Book",
      },
    );
  }

  // 查看是否收藏(文章或团队)
  static Future getIfMark({
    @required int targetId,
    String targetType = "Doc",
  }) async {
    var res = await api.get("/actions", queryParameters: {
      "action_type": "mark",
      "target_id": targetId,
      "target_type": targetType,
    }); // User or Doc
    var asp = res.data as ApiResponse;
    throw UnimplementedError();
  }

  static Future _doActionTarget({
    @required int userId,
    //like, watch, follow, watch-comments, watch-topics, mark, read, reaction
    @required String actionType,
    //Doc, Book, Artboard, ArtboardGroup, ArtboardComment, Comment, Topic, User, Resource, DocVersion, Quan, Note
    @required String targetType,
    int offset,
    // String method = "GET",
  }) async {
    var res = await api.get(
      '/actions/targets',
      queryParameters: {
        "user_id": userId,
        "action_type": actionType,
        "target_type": targetType,
        "offset": offset,
      },
    );
    var asp = res.data as ApiResponse;
    return asp.data;
  }

  static Future<List<ActionSeri>> getMarkList(
      {int offset = 0, int limit = 100}) async {
    var res = await api.get('/mine/marks', queryParameters: {
      'type': 'all',
      'offset': offset,
      'limit': limit,
    });
    var asp = res.data as ApiResponse;
    var list = (asp.data as List).map((e) => ActionSeri.fromJson(e)).toList();
    return list;
  }
}
