class Comments {
  List<CommentData> data;

  Comments({this.data});

  Comments.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<CommentData>();
      json['data'].forEach((v) {
        data.add(new CommentData.fromJson(v));
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

class CommentData {
  int id;
  int userId;
  User user;
  int parentId;
  String format;
  String bodyAsl;
  String bodyHtml;
  int likesCount;
  String createdAt;
  String updatedAt;
  String sSerializer;

  CommentData(
      {this.id,
      this.userId,
      this.user,
      this.parentId,
      this.format,
      this.bodyAsl,
      this.bodyHtml,
      this.likesCount,
      this.createdAt,
      this.updatedAt,
      this.sSerializer});

  CommentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    parentId = json['parent_id'];
    format = json['format'];
    bodyAsl = json['body_asl'];
    bodyHtml = json['body_html'];
    likesCount = json['likes_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  String largeAvatarUrl;
  String mediumAvatarUrl;
  String smallAvatarUrl;
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
      this.largeAvatarUrl,
      this.mediumAvatarUrl,
      this.smallAvatarUrl,
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
    largeAvatarUrl = json['large_avatar_url'];
    mediumAvatarUrl = json['medium_avatar_url'];
    smallAvatarUrl = json['small_avatar_url'];
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
    data['large_avatar_url'] = this.largeAvatarUrl;
    data['medium_avatar_url'] = this.mediumAvatarUrl;
    data['small_avatar_url'] = this.smallAvatarUrl;
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
