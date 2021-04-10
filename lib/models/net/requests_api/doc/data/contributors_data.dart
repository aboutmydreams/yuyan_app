class Contributors {
  List<User> data;

  Contributors({this.data});

  Contributors.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <User>[];
      json['data'].forEach((v) {
        data.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int id;
  String type;
  String login;
  String description;
  String name;
  String avatar;
  String avatarUrl;
  int followersCount;
  int followingCount;
  int role;
  String createdAt;
  String updatedAt;
  bool isPaid;
  String sSerializer;

  User(
      {this.id,
      this.type,
      this.login,
      this.description,
      this.name,
      this.avatar,
      this.avatarUrl,
      this.followersCount,
      this.followingCount,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.isPaid,
      this.sSerializer});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    login = json['login'];
    description = json['description'];
    name = json['name'];
    avatar = json['avatar'];
    avatarUrl = json['avatar_url'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isPaid = json['isPaid'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['login'] = this.login;
    data['description'] = this.description;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['avatar_url'] = this.avatarUrl;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['isPaid'] = this.isPaid;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
