class Comments {
  Meta meta;
  List<CommentData> data;

  Comments({this.meta, this.data});

  Comments.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = new List<CommentData>();
      json['data'].forEach((v) {
        data.add(new CommentData.fromJson(v));
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
  dynamic activeReview;

  Meta({this.activeReview});

  Meta.fromJson(Map<String, dynamic> json) {
    activeReview = json['activeReview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activeReview'] = this.activeReview;
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
  int likesCount;
  int mood;
  String createdAt;
  String updatedAt;
  int status;
  int toUserId;
  String type;
  int selectionId;
  dynamic selectionType;
  String sSerializer;

  CommentData(
      {this.id,
      this.userId,
      this.user,
      this.parentId,
      this.format,
      this.bodyAsl,
      this.likesCount,
      this.mood,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.toUserId,
      this.type,
      this.selectionId,
      this.selectionType,
      this.sSerializer});

  CommentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    parentId = json['parent_id'];
    format = json['format'];
    bodyAsl = json['body_asl'];
    likesCount = json['likes_count'];
    mood = json['mood'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    toUserId = json['to_user_id'];
    type = json['type'];
    selectionId = json['selection_id'];
    selectionType = json['selection_type'];
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
    data['likes_count'] = this.likesCount;
    data['mood'] = this.mood;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['to_user_id'] = this.toUserId;
    data['type'] = this.type;
    data['selection_id'] = this.selectionId;
    data['selection_type'] = this.selectionType;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}

class User {
  int id;
  String login;
  String name;
  String avatarUrl;
  int followersCount;
  int followingCount;
  bool isPaid;
  String sSerializer;

  User(
      {this.id,
      this.login,
      this.name,
      this.avatarUrl,
      this.followersCount,
      this.followingCount,
      this.isPaid,
      this.sSerializer});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    name = json['name'];
    avatarUrl = json['avatar_url'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    isPaid = json['isPaid'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['name'] = this.name;
    data['avatar_url'] = this.avatarUrl;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['isPaid'] = this.isPaid;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
