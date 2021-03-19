import 'package:yuyan_app/model/document/group_home/setting_seri.dart';
import 'package:yuyan_app/model/serializer/serializer.dart';

class GroupViewBlockSeri {
  int id;
  String type;
  String title;
  String icon;
  String cover;
  int rank;
  SettingSeri setting;
  List<GroupViewBlockSeri> placements;
  List<GroupViewBlockSeri> blocks;
  Serializer data;
  String serializer;

  GroupViewBlockSeri({
    this.id,
    this.type,
    this.title,
    this.icon,
    this.cover,
    this.rank,
    this.setting,
    this.placements,
    this.blocks,
    this.data,
    this.serializer,
  });

  GroupViewBlockSeri.fromJson(dynamic json) {
    id = json["id"];
    type = json["type"];
    title = json["title"];
    icon = json["icon"];
    cover = json["cover"];
    rank = json["rank"];
    if (json['setting'] != null) {
      setting = SettingSeri.fromJson(json['setting']);
    }
    if (json["placements"] != null) {
      placements = [];
      json["placements"].forEach((v) {
        placements.add(GroupViewBlockSeri.fromJson(v));
      });
    }
    if (json["blocks"] != null) {
      blocks = (json["blocks"] as List)
          .map((e) => GroupViewBlockSeri.fromJson(e))
          .toList();
    }
    if (json["data"] != null) {
      data = Serializer.fromJson(json["data"]);
    }
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["type"] = type;
    map["title"] = title;
    map["icon"] = icon;
    map["cover"] = cover;
    map["rank"] = rank;
    if (setting != null) {
      map['setting'] = setting.toJson();
    }
    if (placements != null) {
      map["placements"] = placements.map((v) => v.toJson()).toList();
    }
    if (blocks != null) {
      map["blocks"] = blocks.map((e) => e.toJson()).toList();
    }
    if (data != null) {
      map['data'] = data.toJson();
    }
    map["_serializer"] = serializer;
    return map;
  }
}
