import 'package:flutter/material.dart';
import 'package:yuyan_app/models/net/requests/dio_requests.dart';

class AttentionPage extends StatefulWidget {
  AttentionPage({Key key}) : super(key: key);

  @override
  _AttentionPageState createState() => _AttentionPageState();
}

class _AttentionPageState extends State<AttentionPage> {
  List attentdatas = [1, 2];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAttentData();
  }

  getAttentData() async {
    var data = await DioReq.get("/events?offset=0");
    print(data.toString());
    List data_list = [];
    for (Map<String, dynamic> i in data["data"]) {
      Map<String, dynamic> one_data = {};
      one_data["who"] = i["actor"]["name"];
      one_data["user_id"] = i["actor"]["id"];
      one_data["avatar_url"] = i["actor"]["avatar_url"];
      one_data["do"] = i["event_type"];
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
    print(data_list);
    setState(() {
      attentdatas = data["data"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: attentdatas.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Text("data");
        } else {
          return Text("data");
        }
      },
    );
  }
}
