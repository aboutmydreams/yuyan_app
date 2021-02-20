import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/comments_data.dart';
import 'package:yuyan_app/models/net/requests_api/group/data/group_home_data.dart';

import 'data/group_book_data.dart';
import 'data/group_member_data.dart';
import 'data/group_topic_data.dart';
import 'data/one_topic/topic_detail_data.dart';

class DioGroup {
  // 首页数据
  // 2020年11月19日，语雀不在放具体内容在里面了
  static getHomeData({int groupId, bool onlyUser}) async {
    var res =
        await DioReq.get("/groups/$groupId/bookstacks?", onlyUser: onlyUser);
    GroupHomeJson theData = GroupHomeJson.fromJson(res);
    return theData;
  }

  // 团队知识库数据
  static getBookData({int groupId, bool onlyUser}) async {
    var res = await DioReq.get("/groups/$groupId/books?archived=include&q=",
        onlyUser: onlyUser);
    GroupBookJson theData = GroupBookJson.fromJson(res);
    return theData;
  }

  // 团队成员数据
  static getMemberData({int groupId, bool onlyUser}) async {
    var res = await DioReq.get("/groups/$groupId/users?with_count=true",
        onlyUser: onlyUser);
    MemberJson theData = MemberJson.fromJson(res);
    return theData;
  }

  // 团队话题数据
  static getTopicData(
      {int groupId, int offset: 0, String state: "open", bool onlyUser}) async {
    var res = await DioReq.get(
        "/topics?assignee_id=&group_id=$groupId&kanban_id=&label_ids=&milestone_id=&mode=&offset=$offset&privacy=&q=&state=$state&user_id=",
        onlyUser: onlyUser);
    GroupTopicJson theData = GroupTopicJson.fromJson(res);
    return theData;
  }

  // 获取话题主题
  static getOneTopicData({int groupId, int iid: 1, bool onlyUser}) async {
    var res =
        await DioReq.get("/topics/$iid?group_id=$groupId", onlyUser: onlyUser);
    TopicDetailJson theData = TopicDetailJson.fromJson(res);
    return theData;
  }

  // 话题评论列表
  static getComments({int commentId, bool onlyUser}) async {
    var ans = await DioReq.get(
        "/comments?commentable_id=$commentId&commentable_type=Topic",
        onlyUser: onlyUser);
    return Comments.fromJson(ans);
  }

  // 判断是否有讨论区
  static getIfHavaTopic({int groupId, bool onlyUser}) async {
    var ans = await DioReq.get('/groups/$groupId/homepage?include_data=true');
    return ans.toString().contains('讨论区');
  }
}
