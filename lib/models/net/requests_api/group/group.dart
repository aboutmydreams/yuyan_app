import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/comments_data.dart';

import 'data/group_book_data.dart';
import 'data/group_home_data.dart';
import 'data/group_member_data.dart';
import 'data/group_topic_data.dart';
import 'data/one_topic/topic_comment_data.dart';
import 'data/one_topic/topic_detail_data.dart';

class DioGroup {
  // 首页数据
  static getHomeData({int groupId}) async {
    var res = await DioReq.get("/groups/$groupId/homepage?");
    GroupHomeJson theData = GroupHomeJson.fromJson(res);
    return theData;
  }

  // 团队知识库数据
  static getBookData({int groupId}) async {
    var res = await DioReq.get("/groups/$groupId/books?archived=include&q=");
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

  // 获取话题主题
  static getOneTopicData({int groupId, int iid: 1}) async {
    var res = await DioReq.get("/topics/$iid?group_id=$groupId");
    TopicDetailJson theData = TopicDetailJson.fromJson(res);
    return theData;
  }

  // 话题评论列表
  static getComments(int commentId) async {
    var ans = await DioReq.get(
        "/comments?commentable_id=$commentId&commentable_type=Topic");
    return Comments.fromJson(ans);
  }
}
