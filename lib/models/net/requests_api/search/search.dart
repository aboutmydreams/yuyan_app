import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'dart:convert';
import 'data/artboard_data.dart';
import 'data/doc_data.dart';
import 'data/group_data.dart';
import 'data/repos_data.dart';
import 'data/topic_data.dart';
import 'data/user_data.dart';

class DioSearch {
  // 搜索文档
  static getBaidu({String text}) async {
    var url =
        "http://www.baidu.com/sugrec?pre=1&p=3&ie=utf-8&json=1&prod=pc&from=pc_web&wd=$text";
    var ans =
        await DioReq.get(url, headers: {"Content-Type": "application/json"});
    print(ans);

    Map valueMap = jsonDecode(ans);

    if (valueMap.containsKey("g")) {
      List ansList = [];
      ans["g"].forEach((element) => ansList.add(element));
      return ansList;
    } else {
      return [];
    }
  }

  // 搜索文档
  static getDoc({String text, int page, bool aboutMe: false}) async {
    var url = "/zsearch?p=$page&q=$text&scope=&type=doc";
    url = aboutMe ? url + "&related=true" : url;
    var ans = await DioReq.get(url);
    return SearchDocJson.fromJson(ans);
  }

  // 搜索知识库
  static getRepos({String text, int page, bool aboutMe: false}) async {
    var url = "/zsearch?p=$page&q=$text&scope=&type=book";
    url = aboutMe ? url + "&related=true" : url;
    var ans = await DioReq.get(url);
    return SearchReposJson.fromJson(ans);
  }

  // 搜索画板
  static getArt({String text, int page, bool aboutMe: false}) async {
    var url = "/zsearch?p=$page&q=$text&scope=&type=artboard";
    url = aboutMe ? url + "&related=true" : url;
    var ans = await DioReq.get(url);
    return SearchArtboardJson.fromJson(ans);
  }

  // 搜索讨论
  static getTopic({String text, int page, bool aboutMe: false}) async {
    var url = "/zsearch?p=$page&q=$text&scope=&type=topic";
    url = aboutMe ? url + "&related=true" : url;
    var ans = await DioReq.get(url);
    return SearchTopicJson.fromJson(ans);
  }

  // 搜索团队(默认与我无关，这个接口也可以搜索有关，但是没有必要)
  static getGroup({String text, int page}) async {
    var ans = await DioReq.get("/zsearch?p=$page&q=$text&scope=&type=group");
    return SearchGroupJson.fromJson(ans);
  }

  // 搜索用户(默认与我无关)
  static getUser(String text, int page) async {
    var ans = await DioReq.get("/zsearch?p=$page&q=$text&scope=&type=user");
    return SearchUserJson.fromJson(ans);
  }

  // 搜索附件(默认与我相关)
  static getAttachment({String text, int page}) async {
    var ans = await DioReq.get(
        "/zsearch?p=$page&q=$text&scope=&type=attachment&related=true");
    return SearchUserJson.fromJson(ans);
  }
}
