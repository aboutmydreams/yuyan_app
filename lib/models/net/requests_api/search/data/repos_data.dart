class SearchReposJson {
  SearchReponsData data;

  SearchReposJson({this.data});

  SearchReposJson.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new SearchReponsData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class SearchReponsData {
  String type;
  List<Hits> hits;
  int totalHits;
  int numHits;

  SearchReponsData({this.type, this.hits, this.totalHits, this.numHits});

  SearchReponsData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['hits'] != null) {
      hits = new List<Hits>();
      json['hits'].forEach((v) {
        hits.add(new Hits.fromJson(v));
      });
    }
    totalHits = json['totalHits'];
    numHits = json['numHits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.hits != null) {
      data['hits'] = this.hits.map((v) => v.toJson()).toList();
    }
    data['totalHits'] = this.totalHits;
    data['numHits'] = this.numHits;
    return data;
  }
}

class Hits {
  String id;
  String type;
  String abstract;
  String bookName;
  String groupName;
  String name;
  String slug;
  String description;
  String url;
  Record rRecord;

  Hits(
      {this.id,
      this.type,
      this.abstract,
      this.bookName,
      this.groupName,
      this.name,
      this.slug,
      this.description,
      this.url,
      this.rRecord});

  Hits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    abstract = json['abstract'];
    bookName = json['book_name'];
    groupName = json['group_name'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    url = json['url'];
    rRecord =
        json['_record'] != null ? new Record.fromJson(json['_record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['abstract'] = this.abstract;
    data['book_name'] = this.bookName;
    data['group_name'] = this.groupName;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['url'] = this.url;
    if (this.rRecord != null) {
      data['_record'] = this.rRecord.toJson();
    }
    return data;
  }
}

class Record {
  String contentUpdatedAt;
  bool enableComment;
  bool enableExport;
  bool enableVisitorWatermark;
  String copyrightWatermark;
  String imageCopyrightWatermark;
  bool enableSearchEngine;
  bool enableWebhook;
  bool enableTrash;
  bool isBanned;
  int id;
  int spaceId;
  String type;
  String slug;
  String name;
  String description;
  String toc;
  String tocYml;
  String body;
  int userId;
  int creatorId;
  int public;
  int status;
  int excellent;
  int menuType;
  int itemsCount;
  int likesCount;
  int watchesCount;
  int contentUpdatedAtMs;
  dynamic deletedSlug;
  String createdAt;
  String updatedAt;
  dynamic pinnedAt;
  dynamic archivedAt;
  int collaborationCount;
  int stackId;
  int rank;
  int resourceSize;
  String scene;
  String source;
  dynamic deletedAt;
  User user;

  Record(
      {this.contentUpdatedAt,
      this.enableComment,
      this.enableExport,
      this.enableVisitorWatermark,
      this.copyrightWatermark,
      this.imageCopyrightWatermark,
      this.enableSearchEngine,
      this.enableWebhook,
      this.enableTrash,
      this.isBanned,
      this.id,
      this.spaceId,
      this.type,
      this.slug,
      this.name,
      this.description,
      this.toc,
      this.tocYml,
      this.body,
      this.userId,
      this.creatorId,
      this.public,
      this.status,
      this.excellent,
      this.menuType,
      this.itemsCount,
      this.likesCount,
      this.watchesCount,
      this.contentUpdatedAtMs,
      this.deletedSlug,
      this.createdAt,
      this.updatedAt,
      this.pinnedAt,
      this.archivedAt,
      this.collaborationCount,
      this.stackId,
      this.rank,
      this.resourceSize,
      this.scene,
      this.source,
      this.deletedAt,
      this.user});

  Record.fromJson(Map<String, dynamic> json) {
    contentUpdatedAt = json['content_updated_at'];
    enableComment = json['enable_comment'];
    enableExport = json['enable_export'];
    enableVisitorWatermark = json['enable_visitor_watermark'];
    copyrightWatermark = json['copyright_watermark'];
    imageCopyrightWatermark = json['image_copyright_watermark'];
    enableSearchEngine = json['enable_search_engine'];
    enableWebhook = json['enable_webhook'];
    enableTrash = json['enable_trash'];
    isBanned = json['isBanned'];
    id = json['id'];
    spaceId = json['space_id'];
    type = json['type'];
    slug = json['slug'];
    name = json['name'];
    description = json['description'];
    toc = json['toc'];
    tocYml = json['toc_yml'];
    body = json['body'];
    userId = json['user_id'];
    creatorId = json['creator_id'];
    public = json['public'];
    status = json['status'];
    excellent = json['excellent'];
    menuType = json['menu_type'];
    itemsCount = json['items_count'];
    likesCount = json['likes_count'];
    watchesCount = json['watches_count'];
    contentUpdatedAtMs = json['content_updated_at_ms'];
    deletedSlug = json['deleted_slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pinnedAt = json['pinned_at'];
    archivedAt = json['archived_at'];
    collaborationCount = json['collaboration_count'];
    stackId = json['stack_id'];
    rank = json['rank'];
    resourceSize = json['resource_size'];
    scene = json['scene'];
    source = json['source'];
    deletedAt = json['deleted_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content_updated_at'] = this.contentUpdatedAt;
    data['enable_comment'] = this.enableComment;
    data['enable_export'] = this.enableExport;
    data['enable_visitor_watermark'] = this.enableVisitorWatermark;
    data['copyright_watermark'] = this.copyrightWatermark;
    data['image_copyright_watermark'] = this.imageCopyrightWatermark;
    data['enable_search_engine'] = this.enableSearchEngine;
    data['enable_webhook'] = this.enableWebhook;
    data['enable_trash'] = this.enableTrash;
    data['isBanned'] = this.isBanned;
    data['id'] = this.id;
    data['space_id'] = this.spaceId;
    data['type'] = this.type;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['description'] = this.description;
    data['toc'] = this.toc;
    data['toc_yml'] = this.tocYml;
    data['body'] = this.body;
    data['user_id'] = this.userId;
    data['creator_id'] = this.creatorId;
    data['public'] = this.public;
    data['status'] = this.status;
    data['excellent'] = this.excellent;
    data['menu_type'] = this.menuType;
    data['items_count'] = this.itemsCount;
    data['likes_count'] = this.likesCount;
    data['watches_count'] = this.watchesCount;
    data['content_updated_at_ms'] = this.contentUpdatedAtMs;
    data['deleted_slug'] = this.deletedSlug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['pinned_at'] = this.pinnedAt;
    data['archived_at'] = this.archivedAt;
    data['collaboration_count'] = this.collaborationCount;
    data['stack_id'] = this.stackId;
    data['rank'] = this.rank;
    data['resource_size'] = this.resourceSize;
    data['scene'] = this.scene;
    data['source'] = this.source;
    data['deleted_at'] = this.deletedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  String workId;
  String avatarUrl;
  String smallAvatarUrl;
  String mediumAvatarUrl;
  String largeAvatarUrl;
  bool isActive;
  bool isDeactived;
  bool isBanned;
  bool isExtcontact;
  bool isPaid;
  bool hasPaidBefore;
  int id;
  String type;
  String login;
  String name;
  String description;
  String avatar;
  int public;
  int followersCount;
  int followingCount;
  dynamic scene;
  String createdAt;
  String updatedAt;
  int organizationId;
  int memberLevel;
  String expiredAt;
  int status;

  User(
      {this.workId,
      this.avatarUrl,
      this.smallAvatarUrl,
      this.mediumAvatarUrl,
      this.largeAvatarUrl,
      this.isActive,
      this.isDeactived,
      this.isBanned,
      this.isExtcontact,
      this.isPaid,
      this.hasPaidBefore,
      this.id,
      this.type,
      this.login,
      this.name,
      this.description,
      this.avatar,
      this.public,
      this.followersCount,
      this.followingCount,
      this.scene,
      this.createdAt,
      this.updatedAt,
      this.organizationId,
      this.memberLevel,
      this.expiredAt,
      this.status});

  User.fromJson(Map<String, dynamic> json) {
    workId = json['work_id'];
    avatarUrl = json['avatar_url'];
    smallAvatarUrl = json['small_avatar_url'];
    mediumAvatarUrl = json['medium_avatar_url'];
    largeAvatarUrl = json['large_avatar_url'];
    isActive = json['isActive'];
    isDeactived = json['isDeactived'];
    isBanned = json['isBanned'];
    isExtcontact = json['isExtcontact'];
    isPaid = json['isPaid'];
    hasPaidBefore = json['hasPaidBefore'];
    id = json['id'];
    type = json['type'];
    login = json['login'];
    name = json['name'];
    description = json['description'];
    avatar = json['avatar'];
    public = json['public'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    scene = json['scene'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    organizationId = json['organization_id'];
    memberLevel = json['member_level'];
    expiredAt = json['expired_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['work_id'] = this.workId;
    data['avatar_url'] = this.avatarUrl;
    data['small_avatar_url'] = this.smallAvatarUrl;
    data['medium_avatar_url'] = this.mediumAvatarUrl;
    data['large_avatar_url'] = this.largeAvatarUrl;
    data['isActive'] = this.isActive;
    data['isDeactived'] = this.isDeactived;
    data['isBanned'] = this.isBanned;
    data['isExtcontact'] = this.isExtcontact;
    data['isPaid'] = this.isPaid;
    data['hasPaidBefore'] = this.hasPaidBefore;
    data['id'] = this.id;
    data['type'] = this.type;
    data['login'] = this.login;
    data['name'] = this.name;
    data['description'] = this.description;
    data['avatar'] = this.avatar;
    data['public'] = this.public;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['scene'] = this.scene;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['organization_id'] = this.organizationId;
    data['member_level'] = this.memberLevel;
    data['expired_at'] = this.expiredAt;
    data['status'] = this.status;
    return data;
  }
}
