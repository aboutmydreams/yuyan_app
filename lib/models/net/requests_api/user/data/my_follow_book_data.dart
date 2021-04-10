class FollowBookJson {
  List<FollowBookData> data;

  FollowBookJson({this.data});

  FollowBookJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <FollowBookData>[];
      json['data'].forEach((v) {
        data.add(new FollowBookData.fromJson(v));
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

class FollowBookData {
  int id;
  int userId;
  bool ifFollow;
  String actionType;
  String actionName;
  String targetType;
  int targetId;
  String actionOption;
  String title;
  dynamic targetBookId;
  int targetGroupId;
  String createdAt;
  String updatedAt;
  Target target;
  TargetGroup targetGroup;
  dynamic targetBook;
  String sUrl;
  String sSerializer;

  FollowBookData(
      {this.id,
      this.userId,
      this.ifFollow,
      this.actionType,
      this.actionName,
      this.targetType,
      this.targetId,
      this.actionOption,
      this.title,
      this.targetBookId,
      this.targetGroupId,
      this.createdAt,
      this.updatedAt,
      this.target,
      this.targetGroup,
      this.targetBook,
      this.sUrl,
      this.sSerializer});

  FollowBookData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    actionType = json['action_type'];
    actionName = json['action_name'];
    targetType = json['target_type'];
    targetId = json['target_id'];
    actionOption = json['action_option'];
    title = json['title'];
    targetBookId = json['target_book_id'];
    targetGroupId = json['target_group_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    target =
        json['target'] != null ? new Target.fromJson(json['target']) : null;
    targetGroup = json['target_group'] != null
        ? new TargetGroup.fromJson(json['target_group'])
        : null;
    targetBook = json['target_book'];
    sUrl = json['_url'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['action_type'] = this.actionType;
    data['action_name'] = this.actionName;
    data['target_type'] = this.targetType;
    data['target_id'] = this.targetId;
    data['action_option'] = this.actionOption;
    data['title'] = this.title;
    data['target_book_id'] = this.targetBookId;
    data['target_group_id'] = this.targetGroupId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.target != null) {
      data['target'] = this.target.toJson();
    }
    if (this.targetGroup != null) {
      data['target_group'] = this.targetGroup.toJson();
    }
    data['target_book'] = this.targetBook;
    data['_url'] = this.sUrl;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}

class Target {
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
  String pinnedAt;
  dynamic archivedAt;
  int collaborationCount;
  int stackId;
  int rank;
  int resourceSize;
  String scene;
  String source;
  dynamic deletedAt;

  Target(
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
      this.deletedAt});

  Target.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class TargetGroup {
  int id;
  String type;
  String login;
  String name;
  String description;
  String avatarUrl;
  int ownerId;
  int booksCount;
  int publicBooksCount;
  int topicsCount;
  int publicTopicsCount;
  int membersCount;
  int public;
  String scene;
  String createdAt;
  String updatedAt;
  int organizationId;
  bool isPaid;
  dynamic organization;
  dynamic owners;
  String sSerializer;

  TargetGroup(
      {this.id,
      this.type,
      this.login,
      this.name,
      this.description,
      this.avatarUrl,
      this.ownerId,
      this.booksCount,
      this.publicBooksCount,
      this.topicsCount,
      this.publicTopicsCount,
      this.membersCount,
      this.public,
      this.scene,
      this.createdAt,
      this.updatedAt,
      this.organizationId,
      this.isPaid,
      this.organization,
      this.owners,
      this.sSerializer});

  TargetGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    login = json['login'];
    name = json['name'];
    description = json['description'];
    avatarUrl = json['avatar_url'];
    ownerId = json['owner_id'];
    booksCount = json['books_count'];
    publicBooksCount = json['public_books_count'];
    topicsCount = json['topics_count'];
    publicTopicsCount = json['public_topics_count'];
    membersCount = json['members_count'];
    public = json['public'];
    scene = json['scene'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    organizationId = json['organization_id'];
    isPaid = json['isPaid'];
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
    data['description'] = this.description;
    data['avatar_url'] = this.avatarUrl;
    data['owner_id'] = this.ownerId;
    data['books_count'] = this.booksCount;
    data['public_books_count'] = this.publicBooksCount;
    data['topics_count'] = this.topicsCount;
    data['public_topics_count'] = this.publicTopicsCount;
    data['members_count'] = this.membersCount;
    data['public'] = this.public;
    data['scene'] = this.scene;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['organization_id'] = this.organizationId;
    data['isPaid'] = this.isPaid;
    data['organization'] = this.organization;
    data['owners'] = this.owners;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
