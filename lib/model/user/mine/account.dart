class UserAccountSeri {
  int id;
  String name;
  String username;
  String mobile;
  String email;
  String serializer;

  UserAccountSeri({
      this.id, 
      this.name, 
      this.username, 
      this.mobile, 
      this.email, 
      this.serializer});

  UserAccountSeri.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    username = json["username"];
    mobile = json["mobile"];
    email = json["email"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["username"] = username;
    map["mobile"] = mobile;
    map["email"] = email;
    map["_serializer"] = serializer;
    return map;
  }

}