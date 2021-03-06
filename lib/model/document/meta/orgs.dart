class MetaOrg {
  int id;
  String login;
  String name;
  String host;

  MetaOrg({
      this.id, 
      this.login, 
      this.name, 
      this.host});

  MetaOrg.fromJson(dynamic json) {
    id = json["id"];
    login = json["login"];
    name = json["name"];
    host = json["host"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["login"] = login;
    map["name"] = name;
    map["host"] = host;
    return map;
  }

}