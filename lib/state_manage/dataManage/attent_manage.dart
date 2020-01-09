import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';
import 'package:yuyan_app/models/tools/write_json.dart';
import 'package:yuyan_app/state_manage/dataManage/data/attent_data.dart';
import 'package:yuyan_app/state_manage/dataManage/data/selection_data.dart';

// 由于数据过于复杂，快哭了，难以序列化，在这预先处理数据
Map<String, dynamic> fixAttentData(Map<String, dynamic> data) {
  Map<String, dynamic> lastData = {};
  List data_list = [];
  for (Map<String, dynamic> i in data["data"]) {
    Map<String, dynamic> one_data = {};
    one_data["who"] = i["actor"]["name"];
    one_data["user_id"] = i["actor"]["id"];
    one_data["avatar_url"] = i["actor"]["avatar_url"];
    one_data["did"] = i["event_type"];
    one_data["when"] = i["created_at"];
    one_data["subject_type"] = i["subject_type"];
    one_data["event"] = [];
    Map<String, dynamic> subject = i["subject"];

    if (!i.keys.toList().contains("subjects")) {
      Map<String, dynamic> event = {};
      if (subject.keys.toList().contains("title")) {
        event["title"] = subject["title"];
        event["description"] = subject["description"];
      } else {
        event["title"] = "";
        event["description"] = "";
      }

      event["image"] = subject["image"] ?? "";
      event["avatar_url"] = subject["avatar_url"] ?? "";
      String slug = subject["slug"] ?? "";
      String atwho = subject.keys.toList().contains("login")
          ? subject["login"]
          : subject["user"]["login"];
      event["url"] = "https://www.yuque.com/" + atwho + "/" + slug;
      one_data["event"].add(event);
    } else {
      for (Map sub in i["subjects"]) {
        Map<String, dynamic> event = {};
        event["title"] = sub["name"];
        event["description"] = sub["description"];
        event["image"] = "";
        event["book_id"] = sub["book_id"] ?? 0;
        event["avatar_url"] = sub["avatar_url"] ?? "";
        String slug = sub["slug"] ?? "";
        event["url"] =
            "https://www.yuque.com/" + sub["user"]["login"] + "/" + slug;
        one_data["event"].append(event);
      }
    }

    data_list.add(one_data);
  }
  lastData["data"] = data_list;
  lastData["offset"] = data["meta"]["offset"];

  return lastData;
}

class AttentManage extends Model {
  int offset = 0;
  AttentData _attentData = AttentData(data: []);
  AttentData get attentData => _attentData;

  getSaveData() async {
    var attentEvent = await readJson('events');
    AttentData attentionData = AttentData.fromJson(attentEvent);
    _attentData = attentionData;
    notifyListeners();
    return attentionData;
  }

  getMoreData() async {
    var dioData = await DioReq.get("/events?offset=$offset");
    Map mapData = fixAttentData(dioData);
    AttentData attentionData = AttentData.fromJson(mapData);
    offset = attentionData.offset;
    _attentData.data.addAll(attentionData.data);
  }

  saveEventsData() async {
    var dioData = await DioReq.get("/events?offset=0");
    Map mapData = fixAttentData(dioData);

    offset = mapData["offset"];
    await writeJson('events', mapData);
    return 1;
  }

  void update() {
    saveEventsData().then((res) {
      getSaveData();
    });
  }
}
