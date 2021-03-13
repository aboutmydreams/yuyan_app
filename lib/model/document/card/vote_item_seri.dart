class VoteItemSeri {
  String id;
  int count;
  List<String> members;

  VoteItemSeri({this.id, this.count, this.members});

  VoteItemSeri.fromJson(dynamic json) {
    id = json["id"];
    count = json["count"];
    members = json["members"] != null ? json["members"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["count"] = count;
    map["members"] = members;
    return map;
  }
}
