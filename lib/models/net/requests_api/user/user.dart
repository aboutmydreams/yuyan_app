import 'package:yuyan_app/models/tools/get_pref.dart';

import '../requests_api.dart';
import 'data/user_follow_data.dart';
import 'data/user_repos_data.dart';

class DioUser {
  // 获取关注者信息
  static getFollowerData(int offset, int userId) async {
    var res = await DioReq.get(
        "/actions/users?action_type=follow&offset=$offset&target_id=$userId&target_type=User");
    Follows theData = Follows.fromJson(res);
    return theData;
  }

  // 获取关注了信息
  static getFollowingData(int offset, int userId) async {
    var res = await DioReq.get(
        "/actions/targets?action_type=follow&offset=$offset&target_type=User&user_id=$userId");
    Follows theData = Follows.fromJson(res);
    return theData;
  }

  // 获取公开知识库
  static getReposData(String login) async {
    var res = await DioReq.get("/v2/users/$login/repos");
    UserRepos theData = UserRepos.fromJson(res);
    return theData;
  }
}
