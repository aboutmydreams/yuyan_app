class AllDocBookJson {
  List<AllDocBooks> data;

  AllDocBookJson({this.data});

  AllDocBookJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AllDocBooks>[];
      json['data'].forEach((v) {
        data.add(new AllDocBooks.fromJson(v));
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

class AllDocBooks {
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
  dynamic source;
  String createdAt;
  String updatedAt;
  String contentUpdatedAt;
  String pinnedAt;
  String archivedAt;
  int status;
  int stackId;
  int rank;
  String layout;
  String docViewport;
  String docTypography;
  String cover;
  int original;
  User user;
  dynamic creator;
  String sSerializer;

  AllDocBooks(
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
      this.layout,
      this.docViewport,
      this.docTypography,
      this.cover,
      this.original,
      this.user,
      this.creator,
      this.sSerializer});

  AllDocBooks.fromJson(Map<String, dynamic> json) {
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
    layout = json['layout'];
    docViewport = json['doc_viewport'];
    docTypography = json['doc_typography'];
    cover = json['cover'];
    original = json['original'];
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
    data['layout'] = this.layout;
    data['doc_viewport'] = this.docViewport;
    data['doc_typography'] = this.docTypography;
    data['cover'] = this.cover;
    data['original'] = this.original;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['creator'] = this.creator;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}

class Abilities {
  bool createDoc;

  Abilities({this.createDoc});

  Abilities.fromJson(Map<String, dynamic> json) {
    createDoc = json['create_doc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_doc'] = this.createDoc;
    return data;
  }
}

class User {
  int id;
  String type;
  String login;
  String name;
  String description;
  String avatarUrl;
  int public;
  String scene;
  String createdAt;
  String updatedAt;
  int organizationId;
  bool isPaid;
  int memberLevel;
  dynamic organization;
  dynamic owners;
  String sSerializer;
  String avatar;
  int followersCount;
  int followingCount;
  int status;
  dynamic profile;

  User(
      {this.id,
      this.type,
      this.login,
      this.name,
      this.description,
      this.avatarUrl,
      this.public,
      this.scene,
      this.createdAt,
      this.updatedAt,
      this.organizationId,
      this.isPaid,
      this.memberLevel,
      this.organization,
      this.owners,
      this.sSerializer,
      this.avatar,
      this.followersCount,
      this.followingCount,
      this.status,
      this.profile});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    login = json['login'];
    name = json['name'];
    description = json['description'];
    avatarUrl = json['avatar_url'];
    public = json['public'];
    scene = json['scene'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    organizationId = json['organization_id'];
    isPaid = json['isPaid'];
    memberLevel = json['member_level'];
    organization = json['organization'];
    owners = json['owners'];
    sSerializer = json['_serializer'];
    avatar = json['avatar'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    status = json['status'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['login'] = this.login;
    data['name'] = this.name;
    data['description'] = this.description;
    data['avatar_url'] = this.avatarUrl;
    data['public'] = this.public;
    data['scene'] = this.scene;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['organization_id'] = this.organizationId;
    data['isPaid'] = this.isPaid;
    data['member_level'] = this.memberLevel;
    data['organization'] = this.organization;
    data['owners'] = this.owners;
    data['_serializer'] = this.sSerializer;
    data['avatar'] = this.avatar;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['status'] = this.status;
    data['profile'] = this.profile;
    return data;
  }
}
