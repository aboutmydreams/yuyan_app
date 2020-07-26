class UserBookJson {
  List<UserBookData> data;

  UserBookJson({this.data});

  UserBookJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<UserBookData>();
      json['data'].forEach((v) {
        data.add(new UserBookData.fromJson(v));
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

class UserBookData {
  int id;
  String type;
  String slug;
  String name;
  int userId;
  String description;
  int itemsCount;
  int likesCount;
  int watchesCount;
  int creatorId;
  Abilities abilities;
  int public;
  String scene;
  Null source;
  String createdAt;
  String updatedAt;
  String contentUpdatedAt;
  Null pinnedAt;
  Null archivedAt;
  int status;
  Null stackId;
  Null rank;
  List<String> docTypes;
  String layout;
  String docViewport;
  String docTypography;
  User user;
  Null creator;
  String sSerializer;

  UserBookData(
      {this.id,
      this.type,
      this.slug,
      this.name,
      this.userId,
      this.description,
      this.itemsCount,
      this.likesCount,
      this.watchesCount,
      this.creatorId,
      this.abilities,
      this.public,
      this.scene,
      this.source,
      this.createdAt,
      this.updatedAt,
      this.contentUpdatedAt,
      this.pinnedAt,
      this.archivedAt,
      this.status,
      this.stackId,
      this.rank,
      this.docTypes,
      this.layout,
      this.docViewport,
      this.docTypography,
      this.user,
      this.creator,
      this.sSerializer});

  UserBookData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    slug = json['slug'];
    name = json['name'];
    userId = json['user_id'];
    description = json['description'];
    itemsCount = json['items_count'];
    likesCount = json['likes_count'];
    watchesCount = json['watches_count'];
    creatorId = json['creator_id'];
    abilities = json['abilities'] != null
        ? new Abilities.fromJson(json['abilities'])
        : null;
    public = json['public'];
    scene = json['scene'];
    source = json['source'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentUpdatedAt = json['content_updated_at'];
    pinnedAt = json['pinned_at'];
    archivedAt = json['archived_at'];
    status = json['status'];
    stackId = json['stack_id'];
    rank = json['rank'];
    docTypes = json['doc_types'].cast<String>();
    layout = json['layout'];
    docViewport = json['doc_viewport'];
    docTypography = json['doc_typography'];
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
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['items_count'] = this.itemsCount;
    data['likes_count'] = this.likesCount;
    data['watches_count'] = this.watchesCount;
    data['creator_id'] = this.creatorId;
    if (this.abilities != null) {
      data['abilities'] = this.abilities.toJson();
    }
    data['public'] = this.public;
    data['scene'] = this.scene;
    data['source'] = this.source;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['content_updated_at'] = this.contentUpdatedAt;
    data['pinned_at'] = this.pinnedAt;
    data['archived_at'] = this.archivedAt;
    data['status'] = this.status;
    data['stack_id'] = this.stackId;
    data['rank'] = this.rank;
    data['doc_types'] = this.docTypes;
    data['layout'] = this.layout;
    data['doc_viewport'] = this.docViewport;
    data['doc_typography'] = this.docTypography;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['creator'] = this.creator;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}

class Abilities {
  bool read;
  bool update;

  Abilities({this.read, this.update});

  Abilities.fromJson(Map<String, dynamic> json) {
    read = json['read'];
    update = json['update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['read'] = this.read;
    data['update'] = this.update;
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
  Null scene;
  String createdAt;
  String updatedAt;
  bool isPaid;
  int memberLevel;
  Null profile;
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
      this.memberLevel,
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
    memberLevel = json['member_level'];
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
    data['member_level'] = this.memberLevel;
    data['profile'] = this.profile;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
