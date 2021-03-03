class RecentJson {
  List<RecentData> data;

  RecentJson({this.data});

  RecentJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<RecentData>();
      json['data'].forEach((v) {
        data.add(new RecentData.fromJson(v));
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

class RecentData {
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
  dynamic user;
  Share share;
  String sSerializer;
  bool isShare;
  Target target;

  RecentData(
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
      this.isShare,
      this.target});

  RecentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organizationId = json['organization_id'];
    userId = json['user_id'];
    action = json['action.json'];
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
    user = json['user'];
    share = json['share'] != null ? new Share.fromJson(json['share']) : null;
    sSerializer = json['_serializer'];
    isShare = json['isShare'];
    target =
        json['target'] != null ? new Target.fromJson(json['target']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['organization_id'] = this.organizationId;
    data['user_id'] = this.userId;
    data['action.json'] = this.action;
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
    data['user'] = this.user;
    if (this.share != null) {
      data['share'] = this.share.toJson();
    }
    data['_serializer'] = this.sSerializer;
    data['isShare'] = this.isShare;
    if (this.target != null) {
      data['target'] = this.target.toJson();
    }
    return data;
  }
}

class Book {
  int id;
  String type;
  String slug;
  String name;
  User user;
  dynamic creator;
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
  String avatar;
  dynamic profile;
  String sSerializer;
  dynamic scene;
  dynamic organization;
  dynamic owners;

  User(
      {this.id,
      this.type,
      this.login,
      this.name,
      this.avatar,
      this.profile,
      this.sSerializer,
      this.scene,
      this.organization,
      this.owners});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    login = json['login'];
    name = json['name'];
    avatar = json['avatar'];
    profile = json['profile'];
    sSerializer = json['_serializer'];
    scene = json['scene'];
    organization = json['organization'];
    owners = json['owners'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['login'] = this.login;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['profile'] = this.profile;
    data['_serializer'] = this.sSerializer;
    data['scene'] = this.scene;
    data['organization'] = this.organization;
    data['owners'] = this.owners;
    return data;
  }
}

class Share {
  int id;
  String token;
  String targetType;
  int targetId;
  int scope;
  bool passwordEnable;
  String sSerializer;

  Share(
      {this.id,
      this.token,
      this.targetType,
      this.targetId,
      this.scope,
      this.passwordEnable,
      this.sSerializer});

  Share.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    targetType = json['target_type'];
    targetId = json['target_id'];
    scope = json['scope'];
    passwordEnable = json['password_enable'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['token'] = this.token;
    data['target_type'] = this.targetType;
    data['target_id'] = this.targetId;
    data['scope'] = this.scope;
    data['password_enable'] = this.passwordEnable;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}

class Target {
  int id;
  String type;
  String slug;
  String name;
  dynamic scene;
  dynamic user;
  dynamic creator;
  String sSerializer;
  int userId;
  String description;
  int itemsCount;
  int likesCount;
  int watchesCount;
  int creatorId;
  int public;
  dynamic source;
  String createdAt;
  String updatedAt;
  String contentUpdatedAt;
  dynamic pinnedAt;
  dynamic archivedAt;
  int status;
  dynamic stackId;
  dynamic rank;
  String layout;
  String docViewport;
  String docTypography;
  String cover;

  Target(
      {this.id,
      this.type,
      this.slug,
      this.name,
      this.scene,
      this.user,
      this.creator,
      this.sSerializer,
      this.userId,
      this.description,
      this.itemsCount,
      this.likesCount,
      this.watchesCount,
      this.creatorId,
      this.public,
      this.source,
      this.createdAt,
      this.updatedAt,
      this.contentUpdatedAt,
      this.pinnedAt,
      this.archivedAt,
      this.status,
      this.stackId,
      this.rank,
      this.layout,
      this.docViewport,
      this.docTypography,
      this.cover});

  Target.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    slug = json['slug'];
    name = json['name'];
    scene = json['scene'];
    user = json['user'];
    creator = json['creator'];
    sSerializer = json['_serializer'];
    userId = json['user_id'];
    description = json['description'];
    itemsCount = json['items_count'];
    likesCount = json['likes_count'];
    watchesCount = json['watches_count'];
    creatorId = json['creator_id'];
    public = json['public'];
    source = json['source'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentUpdatedAt = json['content_updated_at'];
    pinnedAt = json['pinned_at'];
    archivedAt = json['archived_at'];
    status = json['status'];
    stackId = json['stack_id'];
    rank = json['rank'];
    layout = json['layout'];
    docViewport = json['doc_viewport'];
    docTypography = json['doc_typography'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['scene'] = this.scene;
    data['user'] = this.user;
    data['creator'] = this.creator;
    data['_serializer'] = this.sSerializer;
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['items_count'] = this.itemsCount;
    data['likes_count'] = this.likesCount;
    data['watches_count'] = this.watchesCount;
    data['creator_id'] = this.creatorId;
    data['public'] = this.public;
    data['source'] = this.source;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['content_updated_at'] = this.contentUpdatedAt;
    data['pinned_at'] = this.pinnedAt;
    data['archived_at'] = this.archivedAt;
    data['status'] = this.status;
    data['stack_id'] = this.stackId;
    data['rank'] = this.rank;
    data['layout'] = this.layout;
    data['doc_viewport'] = this.docViewport;
    data['doc_typography'] = this.docTypography;
    data['cover'] = this.cover;
    return data;
  }
}
