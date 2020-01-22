class RecentData {
  List<Recent> data;

  RecentData({this.data});

  RecentData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Recent>();
      json['data'].forEach((v) {
        data.add(new Recent.fromJson(v));
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

class Recent {
  int id;
  int organizationId;
  int userId;
  String action;
  String subjectType;
  String targetType;
  int targetId;
  bool canAddQuickLink;
  bool canEdit;
  String url;
  String createdAt;
  String updatedAt;
  String title;
  Book book;
  User user;
  Null share;
  String sSerializer;
  Target target;
  String avatar;

  Recent(
      {this.id,
      this.organizationId,
      this.userId,
      this.action,
      this.subjectType,
      this.targetType,
      this.targetId,
      this.canAddQuickLink,
      this.canEdit,
      this.url,
      this.createdAt,
      this.updatedAt,
      this.title,
      this.book,
      this.user,
      this.share,
      this.sSerializer,
      this.target,
      this.avatar});

  Recent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizationId = json['organization_id'];
    userId = json['user_id'];
    action = json['action'];
    subjectType = json['subject_type'];
    targetType = json['target_type'];
    targetId = json['target_id'];
    canAddQuickLink = json['canAddQuickLink'];
    canEdit = json['canEdit'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    share = json['share'];
    sSerializer = json['_serializer'];
    target =
        json['target'] != null ? new Target.fromJson(json['target']) : null;
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['organization_id'] = this.organizationId;
    data['user_id'] = this.userId;
    data['action'] = this.action;
    data['subject_type'] = this.subjectType;
    data['target_type'] = this.targetType;
    data['target_id'] = this.targetId;
    data['canAddQuickLink'] = this.canAddQuickLink;
    data['canEdit'] = this.canEdit;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['title'] = this.title;
    if (this.book != null) {
      data['book'] = this.book.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['share'] = this.share;
    data['_serializer'] = this.sSerializer;
    if (this.target != null) {
      data['target'] = this.target.toJson();
    }
    data['avatar'] = this.avatar;
    return data;
  }
}

class Book {
  int id;
  String type;
  String slug;
  String name;
  User user;
  Null creator;
  String sSerializer;

  Book(
      {this.id,
      this.type,
      this.slug,
      this.name,
      this.user,
      this.creator,
      this.sSerializer});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    slug = json['slug'];
    name = json['name'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    creator = json['creator'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['slug'] = this.slug;
    data['name'] = this.name;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['creator'] = this.creator;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}

class User {
  int id;
  String type;
  String login;
  String name;
  String scene;
  Null organization;
  Null owners;
  String sSerializer;

  User(
      {this.id,
      this.type,
      this.login,
      this.name,
      this.scene,
      this.organization,
      this.owners,
      this.sSerializer});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    login = json['login'];
    name = json['name'];
    scene = json['scene'];
    organization = json['organization'];
    owners = json['owners'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['login'] = this.login;
    data['name'] = this.name;
    data['scene'] = this.scene;
    data['organization'] = this.organization;
    data['owners'] = this.owners;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}

class Target {
  int id;
  String type;
  String slug;
  String name;
  String scene;
  User user;
  Null creator;
  String sSerializer;
  String login;
  String avatar;
  Null profile;

  Target(
      {this.id,
      this.type,
      this.slug,
      this.name,
      this.scene,
      this.user,
      this.creator,
      this.sSerializer,
      this.login,
      this.avatar,
      this.profile});

  Target.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    slug = json['slug'];
    name = json['name'];
    scene = json['scene'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    creator = json['creator'];
    sSerializer = json['_serializer'];
    login = json['login'];
    avatar = json['avatar'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['scene'] = this.scene;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['creator'] = this.creator;
    data['_serializer'] = this.sSerializer;
    data['login'] = this.login;
    data['avatar'] = this.avatar;
    data['profile'] = this.profile;
    return data;
  }
}
