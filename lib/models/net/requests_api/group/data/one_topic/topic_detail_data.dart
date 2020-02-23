class TopicDetailJson {
  Meta meta;
  DetailData data;

  TopicDetailJson({this.meta, this.data});

  TopicDetailJson.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    data = json['data'] != null ? new DetailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Meta {
  Abilities abilities;

  Meta({this.abilities});

  Meta.fromJson(Map<String, dynamic> json) {
    abilities = json['abilities'] != null
        ? new Abilities.fromJson(json['abilities'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.abilities != null) {
      data['abilities'] = this.abilities.toJson();
    }
    return data;
  }
}

class Abilities {
  bool read;
  bool update;
  bool destroy;
  bool assign;
  bool pin;

  Abilities({this.read, this.update, this.destroy, this.assign, this.pin});

  Abilities.fromJson(Map<String, dynamic> json) {
    read = json['read'];
    update = json['update'];
    destroy = json['destroy'];
    assign = json['assign'];
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['read'] = this.read;
    data['update'] = this.update;
    data['destroy'] = this.destroy;
    data['assign'] = this.assign;
    data['pin'] = this.pin;
    return data;
  }
}

class DetailData {
  int id;
  int iid;
  String title;
  int userId;
  int assigneeId;
  int groupId;
  dynamic milestoneId;
  dynamic milestone;
  String format;
  dynamic body;
  String bodyAsl;
  String bodyHtml;
  int commentsCount;
  int labelsCount;
  int public;
  dynamic pinnedAt;
  dynamic deletedAt;
  String closedAt;
  String createdAt;
  String updatedAt;
  User user;
  Assignee assignee;
  dynamic group;
  List<Labels> labels;
  String sSerializer;

  DetailData(
      {this.id,
      this.iid,
      this.title,
      this.userId,
      this.assigneeId,
      this.groupId,
      this.milestoneId,
      this.milestone,
      this.format,
      this.body,
      this.bodyAsl,
      this.bodyHtml,
      this.commentsCount,
      this.labelsCount,
      this.public,
      this.pinnedAt,
      this.deletedAt,
      this.closedAt,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.assignee,
      this.group,
      this.labels,
      this.sSerializer});

  DetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iid = json['iid'];
    title = json['title'];
    userId = json['user_id'];
    assigneeId = json['assignee_id'];
    groupId = json['group_id'];
    milestoneId = json['milestone_id'];
    milestone = json['milestone'];
    format = json['format'];
    body = json['body'];
    bodyAsl = json['body_asl'];
    bodyHtml = json['body_html'];
    commentsCount = json['comments_count'];
    labelsCount = json['labels_count'];
    public = json['public'];
    pinnedAt = json['pinned_at'];
    deletedAt = json['deleted_at'];
    closedAt = json['closed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    assignee = json['assignee'] != null
        ? new Assignee.fromJson(json['assignee'])
        : null;
    group = json['group'];
    if (json['labels'] != null) {
      labels = new List<Labels>();
      json['labels'].forEach((v) {
        labels.add(new Labels.fromJson(v));
      });
    }
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iid'] = this.iid;
    data['title'] = this.title;
    data['user_id'] = this.userId;
    data['assignee_id'] = this.assigneeId;
    data['group_id'] = this.groupId;
    data['milestone_id'] = this.milestoneId;
    data['milestone'] = this.milestone;
    data['format'] = this.format;
    data['body'] = this.body;
    data['body_asl'] = this.bodyAsl;
    data['body_html'] = this.bodyHtml;
    data['comments_count'] = this.commentsCount;
    data['labels_count'] = this.labelsCount;
    data['public'] = this.public;
    data['pinned_at'] = this.pinnedAt;
    data['deleted_at'] = this.deletedAt;
    data['closed_at'] = this.closedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.assignee != null) {
      data['assignee'] = this.assignee.toJson();
    }
    data['group'] = this.group;
    if (this.labels != null) {
      data['labels'] = this.labels.map((v) => v.toJson()).toList();
    }
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
  int role;
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
      this.role,
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
    role = json['role'];
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
    data['role'] = this.role;
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

class Assignee {
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
  dynamic profile;
  String sSerializer;

  Assignee(
      {this.id,
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
      this.profile,
      this.sSerializer});

  Assignee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    login = json['login'];
    name = json['name'];
    description = json['description'];
    avatar = json['avatar'];
    avatarUrl = json['avatar_url'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    role = json['role'];
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
    data['role'] = this.role;
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

class Labels {
  int id;
  int groupId;
  String name;
  String color;
  String createdAt;
  String updatedAt;
  String sSerializer;

  Labels(
      {this.id,
      this.groupId,
      this.name,
      this.color,
      this.createdAt,
      this.updatedAt,
      this.sSerializer});

  Labels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    name = json['name'];
    color = json['color'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['name'] = this.name;
    data['color'] = this.color;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
