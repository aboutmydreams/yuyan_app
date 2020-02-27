import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/comments_data.dart';
import 'package:yuyan_app/models/net/requests_api/user/data/my_follow_book_data.dart';
import 'package:yuyan_app/state_manage/dataManage/data/my_page/group/group_data.dart';

import 'data/user_follow_data.dart';
import 'data/user_profile_data.dart';
import 'data/user_repos_data.dart';

class DioUser {
  // 地址、职业的信息根据
  static getProfileData(int userId) async {
    var res = await DioReq.get("/users/$userId/profile?");
    ProfileData theData = ProfileData.fromJson(res);
    return theData;
  }

  // 获取公开知识库
  static getReposData(String login) async {
    var res = await DioReq.get("/v2/users/$login/repos");
    UserBookJson theData = UserBookJson.fromJson(res);
    return theData;
  }

  // 团队信息
  static getGroupData(int userId) async {
    var res = await DioReq.get("/users/$userId/groups?limit=1000&offset=0");
    Group groupData = Group.fromJson(res);
    return groupData;
  }

  /// [关注相关]

  // 获取关注者信息
  static getFollowerData({int userId, int offset: 0}) async {
    var res = await DioReq.get(
        "/actions/users?action_type=follow&offset=$offset&target_id=$userId&target_type=User");
    // 获取关注者中关注了我的 followedList
    List userIdList = res["data"].map((f) => f["id"].toString()).toList();
    String userIdString = userIdList.join('%2C');
    var res2 = await DioReq.get(
        "/actions/user-owned?action_type=follow&target_ids=$userIdString&target_type=User");
    List dataList = res2["data"];
    List<int> followedList = dataList
        .map((onedata) => int.parse(onedata["target_id"].toString()))
        .toList();
    Follows theData = Follows.fromJson(res, followedList);
    return theData;
  }

  // 获取关注了信息
  static getFollowingData({int userId, int offset: 0}) async {
    var res = await DioReq.get(
        "/actions/targets?action_type=follow&offset=$offset&target_type=User&user_id=$userId");
    Follows theData = Follows.fromJson(res, []);
    return theData;
  }

  // 关注他人
  static followUser(int userId) async {
    try {
      Map<String, dynamic> data = {
        "action_type": "follow",
        "target_type": "User",
        "target_id": userId
      };
      Map<String, dynamic> res = await DioReq.post("/actions", data: data);
      print(res);
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

  // 取消关注他人
  static cancelFollow(int userId) async {
    try {
      Map<String, dynamic> data = {
        "action_type": "follow",
        "target_type": "User",
        "target_id": userId
      };
      Map<String, dynamic> res = await DioReq.delete("/actions", data: data);
      print(res);
      if (res.toString() == "{}") {
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
        "/mine/follows?limit=$limit&offset=$offset&q=&type=Book");
    FollowBookJson theData = FollowBookJson.fromJson(ans);
    return theData;
  }

  /// [收藏相关]

  // 查看是否收藏(文章或团队)
  static ifMark({String targetType: "Doc", int targetId}) async {
    Map ans = await DioReq.get(
        "/actions?action_type=mark&target_id=$targetId&target_type=$targetType"); // User or Doc
    return ans["data"]["actioned"] != null;
  }

  // 收藏 Doc Book User(其实是group)
  static mark({String targetType: "Doc", int targetId}) async {
    Map<String, dynamic> data = {
      "target_type": targetType,
      "target_id": targetId
    };
    Map ans = await DioReq.post("/mine/marks", data: data);
    if (ans["data"].toString() == "{ok: 1}") {
      return 1;
    } else {
      return 0;
    }
  }

  // 取消收藏 Doc Book User(其实是group)
  static cancelMark({String targetType: "Doc", int targetId}) async {
    Map<String, dynamic> data = {
      "target_type": targetType,
      "target_id": targetId
    };
    Map ans = await DioReq.delete("/mine/marks", data: data);
    if (ans["data"].toString() == "{ok: 1}") {
      return 1;
    } else {
      return 0;
    }
  }

  /// [评论相关]

  // 评论操作/comments
  static addComment(
      {String comment, int commentId, int parentId, String type: "Doc"}) async {
    // type = "Doc" "Topic"
    Map data = {
      "commentable_type": type,
      "commentable_id": commentId,
      "parent_id": parentId,
      "body_asl":
          "<!doctype lake><meta name=\"doc-version\" content=\"1\" /><p>$comment<cursor /></p>",
      "body":
          "<div class=\"lake-content-editor-core lake-engine\" data-lake-element=\"root\"><p style=\"font-size: 14px; color: rgb(38, 38, 38); line-height: 24px; letter-spacing: 0.05em; outline-style: none; overflow-wrap: break-word; margin: 0px;\">$comment</p></div>",
      "format": "lake"
    };
    Map ans = await DioReq.post("/comments", data: data);
    return ans.containsKey("data");
  }

  // 修改评论操作
  static putComment({String comment, int commentId, String type: "Doc"}) async {
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
    Map ans = await DioReq.put("/comments", data: data);
    return ans.containsKey("data");
  }

  // 评论列表
  static getComments(int docId) async {
    var ans = await DioReq.get(
        "/comments?commentable_id=$docId&commentable_type=Doc");
    return Comments.fromJson(ans);
  }

  // 删除评论操作/comments/348963
  static deleteComment({int commentId}) async {
    Map ans = await DioReq.delete("/comments/$commentId");
    return ans.containsKey("data");
  }

  /// [点赞相关]

  // 点赞操作
  static addLike({int docId, String type: "Doc"}) async {
    Map data = {"action_type": "like", "target_type": type, "target_id": docId};
    Map ans = await DioReq.post("/actions", data: data);
    return ans.containsKey("id");
  }

  // 取消点赞操作
  static deleteLike(int docId) async {
    Map data = {
      "action_type": "like",
      "target_type": "Doc",
      "target_id": docId
    };
    var ans = await DioReq.delete("/actions", data: data);
    return ans == {};
  }
}
