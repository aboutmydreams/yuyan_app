import 'package:yuyan_app/models/net/requests_api/doc/data/contributors_data.dart';
import 'package:yuyan_app/models/net/requests_api/doc/data/prev_next_data.dart';
import 'package:yuyan_app/models/net/requests_api/requests_api.dart';

import 'data/doc_data.dart';
import 'data/doc_data_v2.dart';

class DioDoc {
  // 获取文档内容，作者、时间也在其中
  static getDoc(int bookId, String slug) async {
    var ans = await DioReq.get("/docs/$slug?book_id=$bookId");
    return DocDatas.fromJson(ans);
  }

  // 获取文档内容 使用 v2 接口
  static getDocV2(int bookId, int docId) async {
    var ans = await DioReq.get("/v2/repos/$bookId/docs/$docId");
    return DocV2.fromJson(ans);
  }

  // 创建文档

  // 更新文档

  // 删除文档

  // 获取贡献者列表
  static getContributors(String slug, int bookId) async {
    var ans = await DioReq.get("/docs/$slug/contributors?book_id=$bookId");
    return Contributors.fromJson(ans);
  }

  // 获取浏览量
  static getHits(int docId) async {
    var ans = await DioReq.get("/hits?id=$docId&type=Doc");
    return ans["data"]["hits"];
  }

  // 获取前后文章
  static getPrevNext(int docId) async {
    var ans = await DioReq.get("/docs/$docId/pager?");
    return PrevNext.fromJson(ans);
  }

  // 是否点赞，返回是否与点赞数
  static getAction(int docId) async {
    var ans = await DioReq.get(
        "/actions?action_type=like&target_id=$docId&target_type=Doc");
    bool love = ans["data"]["action"] != null;
    int count = ans["data"]["count"];
    return {"love": love, "count": count};
  }

  // 评论列表

  // 点赞操作

  // 取消点赞操作

  // 评论操作

  // 修改评论操作

  // 删除评论操作

  // 收藏与取消收藏操作

  // 邀请协作

  // 团队成员：/groups/84140/users?with_invited=false
  // 协作者 用的 doc_id
  // /collaborations?offset=0&target_id=1558918&target_type=Doc
}
