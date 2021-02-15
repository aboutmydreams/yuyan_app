class MemberJson {
  Meta meta;
  List<MemberData> data;

  MemberJson({this.meta, this.data});

  MemberJson.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <MemberData>[];
      json['data'].forEach((v) {
        data.add(new MemberData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int count;

  Meta({this.count});

  Meta.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    return data;
  }
}

class MemberData {
  int id;
  int userId;
  int groupId;
  int role;
  int status;
  dynamic departmentName;
  String createdAt;
  String updatedAt;
  String pinnedAt;
  User user;
  dynamic group;
  String sSerializer;

  MemberData(
      {this.id,
      this.userId,
      this.groupId,
      this.role,
      this.status,
      this.departmentName,
      this.createdAt,
      this.updatedAt,
      this.pinnedAt,
      this.user,
      this.group,
      this.sSerializer});

  MemberData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    groupId = json['group_id'];
    role = json['role'];
    status = json['status'];
    departmentName = json['department_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pinnedAt = json['pinned_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    group = json['group'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['group_id'] = this.groupId;
    data['role'] = this.role;
    data['status'] = this.status;
    data['department_name'] = this.departmentName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['pinned_at'] = this.pinnedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['group'] = this.group;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}

class User {
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
  dynamic profile;
  String sSerializer;

  User(
      {this.id,
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
      this.profile,
      this.sSerializer});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    login = json['login'];
    name = json['name'];
    description = json['description'];
    avatar = json['avatar'];
    avatarUrl = json['avatar_url'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    status = json['status'];
    public = json['public'];
    scene = json['scene'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isPaid = json['isPaid'];
    profile = json['profile'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['login'] = this.login;
    data['name'] = this.name;
    data['description'] = this.description;
    data['avatar'] = this.avatar;
    data['avatar_url'] = this.avatarUrl;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['status'] = this.status;
    data['public'] = this.public;
    data['scene'] = this.scene;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['isPaid'] = this.isPaid;
    data['profile'] = this.profile;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
