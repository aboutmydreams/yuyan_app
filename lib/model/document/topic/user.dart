class User {
  int id;
  String type;
  String login;
  String name;
  dynamic description;
  String avatar;
  String avatarUrl;
  int followersCount;
  int followingCount;
  int role;
  int status;
  int public;
  dynamic scene;
  String createdAt;
  String updatedAt;
  bool isPaid;
  int memberLevel;
  dynamic profile;
  String serializer;

  User({
      this.id, 
      this.type, 
      this.login, 
      this.name, 
      this.description, 
      this.avatar, 
      this.avatarUrl, 
      this.followersCount, 
      this.followingCount, 
      this.role, 
      this.status, 
      this.public, 
      this.scene, 
      this.createdAt, 
      this.updatedAt, 
      this.isPaid, 
      this.memberLevel, 
      this.profile, 
      this.serializer});

  User.fromJson(dynamic json) {
    id = json["id"];
    type = json["type"];
    login = json["login"];
    name = json["name"];
    description = json["description"];
    avatar = json["avatar"];
    avatarUrl = json["avatar_url"];
    followersCount = json["followers_count"];
    followingCount = json["following_count"];
    role = json["role"];
    status = json["status"];
    public = json["public"];
    scene = json["scene"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    isPaid = json["isPaid"];
    memberLevel = json["member_level"];
    profile = json["profile"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["type"] = type;
    map["login"] = login;
    map["name"] = name;
    map["description"] = description;
    map["avatar"] = avatar;
    map["avatar_url"] = avatarUrl;
    map["followers_count"] = followersCount;
    map["following_count"] = followingCount;
    map["role"] = role;
    map["status"] = status;
    map["public"] = public;
    map["scene"] = scene;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["isPaid"] = isPaid;
    map["member_level"] = memberLevel;
    map["profile"] = profile;
    map["_serializer"] = serializer;
    return map;
  }

}