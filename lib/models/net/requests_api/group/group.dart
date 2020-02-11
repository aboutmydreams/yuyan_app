import 'package:yuyan_app/models/net/requests/dio_requests.dart';

import 'data/group_book_data.dart';
import 'data/group_home_data.dart';
import 'data/group_member_data.dart';
import 'data/group_topic_data.dart';

class DioGroup {
  // 首页数据
  static getHomeData({int groupId}) async {
    var res = await DioReq.get("/groups/$groupId/homepage?");
    GroupHomeJson theData = GroupHomeJson.fromJson(res);
    return theData;
  }

  // 团队知识库数据
  static getBookData({int groupId}) async {
    var res = await DioReq.get("/groups/$groupId/users?with_count=true");
    GroupBookJson theData = GroupBookJson.fromJson(res);
    return theData;
  }

  // 团队成员数据
  static getMemberData({int groupId}) async {
    var res = await DioReq.get("/groups/$groupId/users?with_count=true");
    MemberJson theData = MemberJson.fromJson(res);
    return theData;
  }

  // 团队话题数据
  static getTopicData(
      {int groupId, int offset: 0, String state: "open"}) async {
    var res = await DioReq.get(
        "/topics?assignee_id=&group_id=$groupId&kanban_id=&label_ids=&milestone_id=&mode=&offset=$offset&privacy=&q=&state=$state&user_id=");
    GroupTopicJson theData = GroupTopicJson.fromJson(res);
    return theData;
  }
}
