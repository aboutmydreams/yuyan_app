class OrganizationLiteSeri {
  String name;
  String logo;
  String login;
  String host;
  String serializer;

  OrganizationLiteSeri({
    this.name,
    this.logo,
    this.login,
    this.host,
    this.serializer,
  });

  OrganizationLiteSeri.fromJson(dynamic json) {
    name = json["name"];
    logo = json["logo"];
    login = json["login"];
    host = json["host"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["logo"] = logo;
    map["login"] = login;
    map["host"] = host;
    map["_serializer"] = serializer;
    return map;
  }
}
