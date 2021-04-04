import 'package:yuyan_app/model/document/group.dart';

class UserLiteSeri {
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

  UserLiteSeri({
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
    this.serializer,
  });

  UserLiteSeri.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    type = json['type'];
    login = json['login'];
    name = json['name'];
    avatar = json['avatar'];
    scene = json['scene'];
    avatarUrl = json['avatar_url'];
    role = json['role'];
    isPaid = json['isPaid'];
    memberLevel = json['member_level'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    description = json['description'];
    serializer = json['_serializer'];
  }

  GroupSeri toGroup() {
    return GroupSeri.fromJson(toJson());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['login'] = this.login;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['scene'] = this.scene;
    data['avatar_url'] = this.avatarUrl;
    data['role'] = this.role;
    data['isPaid'] = this.isPaid;
    data['member_level'] = this.memberLevel;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['description'] = this.description;
    data['_serializer'] = this.serializer;
    return data;
  }
}
