import 'package:yuyan_app/model/document/doc.dart';
import 'package:yuyan_app/model/user/user_profile.dart';
import 'package:yuyan_app/model/user/user_lite_seri.dart';

class UserSeri {
  int id;
  String type;
  String login;
  String name;
  String description;
  String avatar;
  String avatarUrl;
  int followersCount;
  int followingCount;
  int status;
  int public;
  dynamic scene;
  String createdAt;
  String updatedAt;
  bool isPaid;
  int memberLevel;
  UserProfileSeri profile;
  String serializer;
  List<DocSeri> docs;

  UserSeri({
    this.id,
    this.type,
    this.login,
    this.name,
    this.description,
    this.avatar,
    this.avatarUrl,
    this.followersCount,
    this.followingCount,
    this.status,
    this.public,
    this.scene,
    this.createdAt,
    this.updatedAt,
    this.isPaid,
    this.memberLevel,
    this.profile,
    this.serializer,
    this.docs,
  });

  UserSeri.fromJson(dynamic json) {
    id = json["id"];
    type = json["type"];
    login = json["login"];
    name = json["name"];
    description = json["description"];
    avatar = json["avatar"];
    avatarUrl = json["avatar_url"];
    followersCount = json["followers_count"];
    followingCount = json["following_count"];
    status = json["status"];
    public = json["public"];
    scene = json["scene"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    isPaid = json["isPaid"];
    memberLevel = json["member_level"];

    serializer = json["_serializer"];

    if (json["profile"] != null) {
      profile = UserProfileSeri.fromJson(json["profile"]);
    }

    if (json['docs'] != null) {
      docs = (json['docs'] as List).map((e) => DocSeri.fromJson(e)).toList();
    }
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
    map["status"] = status;
    map["public"] = public;
    map["scene"] = scene;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["isPaid"] = isPaid;
    map["member_level"] = memberLevel;
    map["profile"] = profile;
    if (this.docs != null) {
      map["docs"] = docs.map((e) => e.toJson()).toList();
    }
    map["_serializer"] = serializer;
    return map;
  }

  UserLiteSeri toUserLiteSeri() {
    return UserLiteSeri.fromJson(toJson());
  }
}
