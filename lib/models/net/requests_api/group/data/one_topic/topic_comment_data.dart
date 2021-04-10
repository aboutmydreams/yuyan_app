class TopicCommentJson {
  List<OneCommentData> data;

  TopicCommentJson({this.data});

  TopicCommentJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <OneCommentData>[];
      json['data'].forEach((v) {
        data.add(new OneCommentData.fromJson(v));
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

class OneCommentData {
  int id;
  int userId;
  User user;
  int parentId;
  String format;
  String bodyAsl;
  String bodyHtml;
  int likesCount;
  int mood;
  String createdAt;
  String updatedAt;
  int status;
  dynamic toUserId;
  String sSerializer;

  OneCommentData(
      {this.id,
      this.userId,
      this.user,
      this.parentId,
      this.format,
      this.bodyAsl,
      this.bodyHtml,
      this.likesCount,
      this.mood,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.toUserId,
      this.sSerializer});

  OneCommentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    parentId = json['parent_id'];
    format = json['format'];
    bodyAsl = json['body_asl'];
    bodyHtml = json['body_html'];
    likesCount = json['likes_count'];
    mood = json['mood'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    toUserId = json['to_user_id'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['parent_id'] = this.parentId;
    data['format'] = this.format;
    data['body_asl'] = this.bodyAsl;
    data['body_html'] = this.bodyHtml;
    data['likes_count'] = this.likesCount;
    data['mood'] = this.mood;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['to_user_id'] = this.toUserId;
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
