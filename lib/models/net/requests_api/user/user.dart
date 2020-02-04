import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/tools/get_pref.dart';

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
    UserRepos theData = UserRepos.fromJson(res);
    return theData;
  }

  // 获取关注者信息
  static getFollowerData(int offset, int userId) async {
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
  static getFollowingData(int offset, int userId) async {
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
      if (res == {}) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  // 关注知识库

}
