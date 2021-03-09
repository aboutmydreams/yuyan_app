class Contributors {
  int id;
  String type;
  String login;
  String name;
  String avatar;
  dynamic scene;
  String avatarUrl;
  int role;
  bool isPaid;
  int memberLevel;
  int followersCount;
  int followingCount;
  String description;
  String serializer;

  Contributors({
      this.id, 
      this.type, 
      this.login, 
      this.name, 
      this.avatar, 
      this.scene, 
      this.avatarUrl, 
      this.role, 
      this.isPaid, 
      this.memberLevel, 
      this.followersCount, 
      this.followingCount, 
      this.description, 
      this.serializer});

  Contributors.fromJson(dynamic json) {
    id = json["id"];
    type = json["type"];
    login = json["login"];
    name = json["name"];
    avatar = json["avatar"];
    scene = json["scene"];
    avatarUrl = json["avatar_url"];
    role = json["role"];
    isPaid = json["isPaid"];
    memberLevel = json["member_level"];
    followersCount = json["followers_count"];
    followingCount = json["following_count"];
    description = json["description"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["type"] = type;
    map["login"] = login;
    map["name"] = name;
    map["avatar"] = avatar;
    map["scene"] = scene;
    map["avatar_url"] = avatarUrl;
    map["role"] = role;
    map["isPaid"] = isPaid;
    map["member_level"] = memberLevel;
    map["followers_count"] = followersCount;
    map["following_count"] = followingCount;
    map["description"] = description;
    map["_serializer"] = serializer;
    return map;
  }

}