import 'package:yuyan_app/models/net/requests/dio_requests.dart';

import 'data/artboard_data.dart';
import 'data/doc_data.dart';
import 'data/group_data.dart';
import 'data/repos_data.dart';
import 'data/topic_data.dart';
import 'data/user_data.dart';

class DioSearch {
  // 搜索文档
  static getDoc(String text, int page) async {
    var ans = await DioReq.get("/zsearch?p=$page&q=$text&scope=&type=doc");
    return SearchDocJson.fromJson(ans);
  }

  // 搜索知识库
  static getRepos(String text, int page) async {
    var ans = await DioReq.get("/zsearch?p=$page&q=$text&scope=&type=book");
    return SearchReposJson.fromJson(ans);
  }

  // 搜索画板
  static getArt(String text, int page) async {
    var ans = await DioReq.get("/zsearch?p=$page&q=$text&scope=&type=artboard");
    return SearchArtboardJson.fromJson(ans);
  }

  // 搜索讨论
  static getTopic(String text, int page) async {
    var ans = await DioReq.get("/zsearch?p=$page&q=$text&scope=&type=topic");
    return SearchTopicJson.fromJson(ans);
  }

  // 搜索团队
  static getGroup(String text, int page) async {
    var ans = await DioReq.get("/zsearch?p=$page&q=$text&scope=&type=group");
    return SearchGroupJson.fromJson(ans);
  }

  // 搜索用户
  static getUser(String text, int page) async {
    var ans = await DioReq.get("/zsearch?p=$page&q=$text&scope=&type=user");
    return SearchUserJson.fromJson(ans);
  }
}
