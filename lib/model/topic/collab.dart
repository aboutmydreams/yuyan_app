class CollabSeri {
  String host;
  String id;
  String token;

  CollabSeri({this.host, this.id, this.token});

  CollabSeri.fromJson(dynamic json) {
    host = json["host"];
    id = json["id"];
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["host"] = host;
    map["id"] = id;
    map["token"] = token;
    return map;
  }
}
