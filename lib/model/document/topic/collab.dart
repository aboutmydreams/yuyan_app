class Collab {
  String host;
  String id;
  String token;

  Collab({
      this.host, 
      this.id, 
      this.token});

  Collab.fromJson(dynamic json) {
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