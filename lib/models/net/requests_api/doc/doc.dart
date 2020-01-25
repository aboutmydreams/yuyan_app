import 'package:yuyan_app/models/net/requests_api/doc/data/comments_data.dart';
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
    bool like = ans["data"]["action"] != null;
    int count = ans["data"]["count"];
    return {"like": like, "count": count};
  }

  // 评论列表
  static getComments(int docId) async {
    var ans = await DioReq.get(
        "/comments?commentable_id=$docId&commentable_type=Doc");
    return Comments.fromJson(ans);
  }

  // 点赞操作
  static addLike(int docId) async {
    Map data = {
      "action_type": "like",
      "target_type": "Doc",
      "target_id": docId
    };
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

  // 评论操作/comments
  static addComment(String comment, int docId) async {
    Map data = {
      "commentable_type": "Doc",
      "commentable_id": docId,
      "parent_id": null,
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
  static putComment(String comment, int docId) async {
    Map data = {
      "commentable_type": "Doc",
      "commentable_id": docId,
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

  // 删除评论操作/comments/348963
  static deleteComment(String comment, int docId) async {
    Map ans = await DioReq.delete("/comments/$docId");
    return ans.containsKey("data");
  }

  // 收藏与取消收藏操作

  // 邀请协作

  // 团队成员：/groups/84140/users?with_invited=false
  // 协作者 用的 doc_id
  // /collaborations?offset=0&target_id=1558918&target_type=Doc
}
