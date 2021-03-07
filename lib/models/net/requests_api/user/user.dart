import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/comments_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/my_follow_book_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/user_info_data.dart';
import 'package:yuyan_app/models/oauth2/random_string/random_string.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';

import 'data/user_follow_data.dart';
import 'data/user_profile_data.dart';
import 'data/user_repos_data.dart';

class DioUser {
  // 地址、职业的信息根据
  static getProfileData({int userId}) async {
    var res = await DioReq.get("/users/$userId/profile?");
    ProfileData theData = ProfileData.fromJson(res);
    return theData;
  }

  // v2 基本信息
  static getUserInfo({int userId}) async {
    var res = await DioReq.get("/v2/users/$userId", onlyUser: true);
    UserInfoJson theData = UserInfoJson.fromJson(res);
    return theData;
  }

  // v2 获取公开知识库 暂时弃用
  // static getReposV2({String login}) async {
  //   var res =
  //       await DioReq.get("https://www.yuque.com/api/v2/users/$login/repos");
  //   UserReposJson theData = UserReposJson.fromJson(res);
  //   return theData;
  // }

  // 获取公开知识库
  static getReposData({int userId, bool onlyUser}) async {
    var res = await DioReq.get(
      "/groups/$userId/books?archived=include&limit=200",
      onlyUser: true,
    );
    UserReposJson theData = UserReposJson.fromJson(res);
    return theData;
  }

  // 团队信息
  static getGroupData({int userId}) async {
    var res = await DioReq.get("/users/$userId/groups?limit=1000&offset=0",
        onlyUser: true);
    GroupJson groupData = GroupJson.fromJson(res);
    return groupData;
  }

  /// [关注相关]

  // 获取关注者信息

  static getIfFollow({int userId}) async {
    var res = await DioReq.get(
      "/actions/user-owned?action_type=follow&target_ids=$userId&target_type=User",
      onlyUser: true,
    );
    return res["data"].toString() != '[]';
  }

  // 获取关注者信息
  static getFollowerData({int userId, int offset: 0}) async {
    var res = await DioReq.get(
        "/actions/users?action_type=follow&offset=$offset&target_id=$userId&target_type=User",
        onlyUser: true);
    // 获取关注者中关注了我的 followedList
    List<int> followedList = [];
    List userIdList = res["data"].map((f) => f["id"].toString()).toList();
    if (userIdList.isNotEmpty) {
      String userIdString = userIdList.join('%2C');
      var res2 = await DioReq.get(
          "/actions/user-owned?action_type=follow&target_ids=$userIdString&target_type=User",
          onlyUser: true);
      List dataList = res2["data"];
      followedList = dataList
          .map((onedata) => int.parse(onedata["target_id"].toString()))
          .toList();
    }
    Follows theData = Follows.fromJson(res, followedList);
    return theData;
  }

  static getFollowerData2({int userId, int offset: 0}) async {
    var res = await DioReq.get(
        "/actions/users?action_type=follow&offset=$offset&target_id=$userId&target_type=User",
        onlyUser: true);
    Follows theData = Follows.fromJson(res, []);
    return theData;
  }

  // 获取关注了信息
  static getFollowingData({int userId, int offset: 0}) async {
    var res = await DioReq.get(
        "/actions/targets?action_type=follow&offset=$offset&target_type=User&user_id=$userId",
        onlyUser: true);
    Follows theData = Follows.fromJson(res, []);
    return theData;
  }

  // 关注他人
  static followUser({int userId}) async {
    try {
      Map<String, dynamic> data = {
        "action_type": "follow",
        "target_type": "User",
        "target_id": userId
      };
      Map<String, dynamic> res =
          await DioReq.post("/actions", data: data, onlyUser: true);

      print(res);
      if (res.containsKey("data")) {
        // topModel.myInfoManage.update();
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  // 取消关注他人
  static cancelFollow({int userId}) async {
    try {
      Map<String, dynamic> data = {
        "action_type": "follow",
        "target_type": "User",
        "target_id": userId
      };
      Map<String, dynamic> res =
          await DioReq.delete("/actions", data: data, onlyUser: true);
      if (res.toString() == "{}") {
        // topModel.myInfoManage.update();
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  // 我关注的知识库
  static getFollowBook({int offset: 0, int limit: 200}) async {
    Map ans = await DioReq.get(
        "/mine/follows?limit=$limit&offset=$offset&q=&type=Book",
        onlyUser: true);
    FollowBookJson theData = FollowBookJson.fromJson(ans);
    return theData;
  }

  /// [收藏相关]

  // 查看是否收藏(文章或团队)
  static ifMark(
      {String targetType: "Doc", int targetId, bool onlyUser: false}) async {
    var ans = await DioReq.get(
      "/actions?action_type=mark&target_id=$targetId&target_type=$targetType",
      onlyUser: onlyUser,
    ); // User or Doc
    return ans["data"]["actioned"] != null;
  }

  // 收藏 Doc Book User(其实是group)
  static mark(
      {String targetType: "Doc", int targetId, bool onlyUser: false}) async {
    Map<String, dynamic> data = {
      "target_type": targetType,
      "target_id": targetId
    };
    Map ans = await DioReq.post("/mine/marks", data: data, onlyUser: onlyUser);
    if (ans["data"].toString() == "{ok: 1}") {
      return 1;
    } else {
      return 0;
    }
  }

  // 取消收藏 Doc Book User(其实是group)
  static cancelMark(
      {String targetType: "Doc", int targetId, bool onlyUser: false}) async {
    Map<String, dynamic> data = {
      "target_type": targetType,
      "target_id": targetId
    };
    Map ans =
        await DioReq.delete("/mine/marks", data: data, onlyUser: onlyUser);
    if (ans["data"].toString() == "{ok: 1}") {
      return 1;
    } else {
      return 0;
    }
  }

  /// [话题相关]
  // 添加新的话题
  static addTopic(
      {String title, String body, int groupId, bool onlyUser: false}) async {
    String uuid = randomString(64);
    Map<String, dynamic> data = {
      "group_id": groupId,
      "title": title,
      "body_asl":
          "<div class=\"lake-content-editor-core lake-engine\" data-lake-element=\"root\"><p style=\"font-size: 14px; color: rgb(38, 38, 38); line-height: 24px; letter-spacing: 0.05em; outline-style: none; overflow-wrap: break-word; margin: 0px;\">$body</p></div>",
      "assignee_id": null,
      "format": "lake",
      "public": 1,
      "milestone_id": null,
      "uuid": uuid
    };
    print(data);
    var res = await DioReq.post('/topics', data: data, onlyUser: onlyUser);
    return res.toString().contains("id");
  }

  /// [评论相关]

  // 评论操作/comments
  static addComment({
    String comment,
    int commentId,
    int parentId,
    String type: "Doc",
    bool onlyUser: false,
  }) async {
    // type = "Doc" "Topic"
    Map<String, dynamic> data = {
      "commentable_type": type,
      "commentable_id": commentId,
      "parent_id": parentId,
      "body_asl":
          "<!doctype lake><meta name=\"doc-version\" content=\"1\" /><p>$comment<cursor /></p>",
      "body":
          "<div class=\"lake-content-editor-core lake-engine\" data-lake-element=\"root\"><p style=\"font-size: 14px; color: rgb(38, 38, 38); line-height: 24px; letter-spacing: 0.05em; outline-style: none; overflow-wrap: break-word; margin: 0px;\">$comment</p></div>",
      "format": "lake"
    };
    var ans = await DioReq.post("/comments", data: data, onlyUser: onlyUser);
    return ans.toString().contains("data");
  }

  // 修改评论操作
  static putComment(
      {String comment,
      int commentId,
      String type: "Doc",
      bool onlyUser: false}) async {
    Map data = {
      "commentable_type": type,
      "commentable_id": commentId,
      "parent_id": null,
      "body_asl":
          "<!doctype lake><meta name=\"doc-version\" content=\"1\" /><p>$comment<cursor /></p>",
      "body":
          "<div class=\"lake-content-editor-core lake-engine\" data-lake-element=\"root\"><p style=\"font-size: 14px; color: rgb(38, 38, 38); line-height: 24px; letter-spacing: 0.05em; outline-style: none; overflow-wrap: break-word; margin: 0px;\">$comment</p></div>",
      "format": "lake"
    };
    Map ans = await DioReq.put("/comments", data: data, onlyUser: onlyUser);
    return ans.containsKey("data");
  }

  // 评论列表
  static getComments({int docId, bool onlyUser: false}) async {
    var ans = await DioReq.get(
        "/comments?commentable_id=$docId&commentable_type=Doc&include_section=true",
        onlyUser: onlyUser);
    if (ans == 404) {
      // 禁止用户评论
      return Comments(data: [], meta: null);
    } else {
      return Comments.fromJson(ans);
    }
  }

  // 删除评论操作/comments/348963
  static deleteComment({int commentId, bool onlyUser: false}) async {
    Map ans = await DioReq.delete("/comments/$commentId", onlyUser: onlyUser);
    return ans.containsKey("data");
  }

  /// [知识库相关]
  // 是否关注
  static ifWatch(
      {int bookId, String type: "Book", bool onlyUser: false}) async {
    var ans = await DioReq.get(
        "/actions?action_type=watch&target_id=$bookId&target_type=$type",
        onlyUser: onlyUser);
    return ans["actioned"] == null;
  }

  static watchBook(
      {int bookId, String actionOption: "normal", bool onlyUser: false}) async {
    try {
      Map<String, dynamic> data = {
        "action_type": "watch",
        "target_type": "Book",
        "target_id": bookId,
        "action_option": actionOption // normal 关注提醒, notify 消息 邮件推送
      };
      Map<String, dynamic> res =
          await DioReq.post("/actions", data: data, onlyUser: onlyUser);
      if (res.containsKey("data")) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  /// [点赞相关]
  // 是否点赞
  static ifLike({int docId, String type: "Doc", bool onlyUser: false}) async {
    var ans = await DioReq.get(
        "/actions?action_type=like&target_id=$docId&target_type=$type",
        onlyUser: onlyUser);
    return ans["actioned"] != null;
  }

  // 点赞操作
  static addLike({int docId, String type: "Doc", bool onlyUser: false}) async {
    Map<String, dynamic> data = {
      "action_type": "like",
      "target_type": type,
      "target_id": docId
    };
    var ans = await DioReq.post("/actions", data: data, onlyUser: onlyUser);
    print(ans);
    return ans;
  }

  // 取消点赞操作
  static deleteLike({int docId, bool onlyUser: false}) async {
    Map<String, dynamic> data = {
      "action_type": "like",
      "target_type": "Doc",
      "target_id": docId
    };
    var ans = await DioReq.delete("/actions", data: data, onlyUser: onlyUser);
    return ans == {};
  }
}
