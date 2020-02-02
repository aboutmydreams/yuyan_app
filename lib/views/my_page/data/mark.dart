class MarkJson {
  List<MarkData> data;

  MarkJson({this.data});

  MarkJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<MarkData>();
      json['data'].forEach((v) {
        data.add(new MarkData.fromJson(v));
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

class MarkData {
  int id;
  int userId;
  String actionType;
  String actionName;
  String targetType;
  int targetId;
  String actionOption;
  String title;
  int targetBookId;
  int targetGroupId;
  String createdAt;
  String updatedAt;
  Target target;
  TargetGroup targetGroup;
  TargetBook targetBook;
  String sUrl;
  String sSerializer;

  MarkData(
      {this.id,
      this.userId,
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

  MarkData.fromJson(Map<String, dynamic> json) {
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
    targetBook = json['target_book'] != null
        ? new TargetBook.fromJson(json['target_book'])
        : null;
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
    if (this.targetBook != null) {
      data['target_book'] = this.targetBook.toJson();
    }
    data['_url'] = this.sUrl;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}

class Target {
  String contentUpdatedAt;
  String body;
  String bodyAsl;
  String bodyDraft;
  String bodyDraftAsl;
  bool isSuspect;
  int id;
  int spaceId;
  String type;
  dynamic subType;
  String slug;
  int bookId;
  int userId;
  String title;
  dynamic tag;
  String cover;
  String description;
  String customDescription;
  String titleDraft;
  String format;
  int status;
  int readStatus;
  int public;
  int commentsCount;
  int likesCount;
  int collaborationCount;
  int lastEditorId;
  int draftVersion;
  dynamic deletedSlug;
  int wordCount;
  String createdAt;
  String updatedAt;
  String publishedAt;
  String firstPublishedAt;
  String selectedAt;
  String editorMeta;
  dynamic deletedAt;
  User user;
  bool enableComment;
  bool enableExport;
  bool enableVisitorWatermark;
  String copyrightWatermark;
  String imageCopyrightWatermark;
  bool enableSearchEngine;
  bool enableWebhook;
  bool enableTrash;
  bool isBanned;
  String name;
  String toc;
  String tocYml;
  int creatorId;
  int excellent;
  int menuType;
  int itemsCount;
  int watchesCount;
  int contentUpdatedAtMs;
  dynamic pinnedAt;
  dynamic archivedAt;
  int stackId;
  int rank;
  int resourceSize;
  dynamic scene;
  dynamic source;

  Target(
      {this.contentUpdatedAt,
      this.body,
      this.bodyAsl,
      this.bodyDraft,
      this.bodyDraftAsl,
      this.isSuspect,
      this.id,
      this.spaceId,
      this.type,
      this.subType,
      this.slug,
      this.bookId,
      this.userId,
      this.title,
      this.tag,
      this.cover,
      this.description,
      this.customDescription,
      this.titleDraft,
      this.format,
      this.status,
      this.readStatus,
      this.public,
      this.commentsCount,
      this.likesCount,
      this.collaborationCount,
      this.lastEditorId,
      this.draftVersion,
      this.deletedSlug,
      this.wordCount,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.firstPublishedAt,
      this.selectedAt,
      this.editorMeta,
      this.deletedAt,
      this.user,
      this.enableComment,
      this.enableExport,
      this.enableVisitorWatermark,
      this.copyrightWatermark,
      this.imageCopyrightWatermark,
      this.enableSearchEngine,
      this.enableWebhook,
      this.enableTrash,
      this.isBanned,
      this.name,
      this.toc,
      this.tocYml,
      this.creatorId,
      this.excellent,
      this.menuType,
      this.itemsCount,
      this.watchesCount,
      this.contentUpdatedAtMs,
      this.pinnedAt,
      this.archivedAt,
      this.stackId,
      this.rank,
      this.resourceSize,
      this.scene,
      this.source});

  Target.fromJson(Map<String, dynamic> json) {
    contentUpdatedAt = json['content_updated_at'];
    body = json['body'];
    bodyAsl = json['body_asl'];
    bodyDraft = json['body_draft'];
    bodyDraftAsl = json['body_draft_asl'];
    isSuspect = json['isSuspect'];
    id = json['id'];
    spaceId = json['space_id'];
    type = json['type'];
    subType = json['sub_type'];
    slug = json['slug'];
    bookId = json['book_id'];
    userId = json['user_id'];
    title = json['title'];
    tag = json['tag'];
    cover = json['cover'];
    description = json['description'];
    customDescription = json['custom_description'];
    titleDraft = json['title_draft'];
    format = json['format'];
    status = json['status'];
    readStatus = json['read_status'];
    public = json['public'];
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
    collaborationCount = json['collaboration_count'];
    lastEditorId = json['last_editor_id'];
    draftVersion = json['draft_version'];
    deletedSlug = json['deleted_slug'];
    wordCount = json['word_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    publishedAt = json['published_at'];
    firstPublishedAt = json['first_published_at'];
    selectedAt = json['selected_at'];
    editorMeta = json['editor_meta'];
    deletedAt = json['deleted_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    enableComment = json['enable_comment'];
    enableExport = json['enable_export'];
    enableVisitorWatermark = json['enable_visitor_watermark'];
    copyrightWatermark = json['copyright_watermark'];
    imageCopyrightWatermark = json['image_copyright_watermark'];
    enableSearchEngine = json['enable_search_engine'];
    enableWebhook = json['enable_webhook'];
    enableTrash = json['enable_trash'];
    isBanned = json['isBanned'];
    name = json['name'];
    toc = json['toc'];
    tocYml = json['toc_yml'];
    creatorId = json['creator_id'];
    excellent = json['excellent'];
    menuType = json['menu_type'];
    itemsCount = json['items_count'];
    watchesCount = json['watches_count'];
    contentUpdatedAtMs = json['content_updated_at_ms'];
    pinnedAt = json['pinned_at'];
    archivedAt = json['archived_at'];
    stackId = json['stack_id'];
    rank = json['rank'];
    resourceSize = json['resource_size'];
    scene = json['scene'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content_updated_at'] = this.contentUpdatedAt;
    data['body'] = this.body;
    data['body_asl'] = this.bodyAsl;
    data['body_draft'] = this.bodyDraft;
    data['body_draft_asl'] = this.bodyDraftAsl;
    data['isSuspect'] = this.isSuspect;
    data['id'] = this.id;
    data['space_id'] = this.spaceId;
    data['type'] = this.type;
    data['sub_type'] = this.subType;
    data['slug'] = this.slug;
    data['book_id'] = this.bookId;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['tag'] = this.tag;
    data['cover'] = this.cover;
    data['description'] = this.description;
    data['custom_description'] = this.customDescription;
    data['title_draft'] = this.titleDraft;
    data['format'] = this.format;
    data['status'] = this.status;
    data['read_status'] = this.readStatus;
    data['public'] = this.public;
    data['comments_count'] = this.commentsCount;
    data['likes_count'] = this.likesCount;
    data['collaboration_count'] = this.collaborationCount;
    data['last_editor_id'] = this.lastEditorId;
    data['draft_version'] = this.draftVersion;
    data['deleted_slug'] = this.deletedSlug;
    data['word_count'] = this.wordCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['published_at'] = this.publishedAt;
    data['first_published_at'] = this.firstPublishedAt;
    data['selected_at'] = this.selectedAt;
    data['editor_meta'] = this.editorMeta;
    data['deleted_at'] = this.deletedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['enable_comment'] = this.enableComment;
    data['enable_export'] = this.enableExport;
    data['enable_visitor_watermark'] = this.enableVisitorWatermark;
    data['copyright_watermark'] = this.copyrightWatermark;
    data['image_copyright_watermark'] = this.imageCopyrightWatermark;
    data['enable_search_engine'] = this.enableSearchEngine;
    data['enable_webhook'] = this.enableWebhook;
    data['enable_trash'] = this.enableTrash;
    data['isBanned'] = this.isBanned;
    data['name'] = this.name;
    data['toc'] = this.toc;
    data['toc_yml'] = this.tocYml;
    data['creator_id'] = this.creatorId;
    data['excellent'] = this.excellent;
    data['menu_type'] = this.menuType;
    data['items_count'] = this.itemsCount;
    data['watches_count'] = this.watchesCount;
    data['content_updated_at_ms'] = this.contentUpdatedAtMs;
    data['pinned_at'] = this.pinnedAt;
    data['archived_at'] = this.archivedAt;
    data['stack_id'] = this.stackId;
    data['rank'] = this.rank;
    data['resource_size'] = this.resourceSize;
    data['scene'] = this.scene;
    data['source'] = this.source;
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
  int spaceId;
  String type;
  String login;
  String name;
  String description;
  String avatar;
  int ownerId;
  int topicsCount;
  int publicTopicsCount;
  int membersCount;
  int booksCount;
  int publicBooksCount;
  int followersCount;
  int followingCount;
  int accountId;
  int role;
  int status;
  int public;
  bool wantsEmail;
  bool wantsMarketingEmail;
  int topicUpdatedAtMs;
  dynamic deletedSlug;
  String language;
  int organizationId;
  dynamic empType;
  dynamic groupDepartmentUpdatedAt;
  int memberLevel;
  String expiredAt;
  dynamic scene;
  dynamic source;
  dynamic maxMember;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

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
      this.spaceId,
      this.type,
      this.login,
      this.name,
      this.description,
      this.avatar,
      this.ownerId,
      this.topicsCount,
      this.publicTopicsCount,
      this.membersCount,
      this.booksCount,
      this.publicBooksCount,
      this.followersCount,
      this.followingCount,
      this.accountId,
      this.role,
      this.status,
      this.public,
      this.wantsEmail,
      this.wantsMarketingEmail,
      this.topicUpdatedAtMs,
      this.deletedSlug,
      this.language,
      this.organizationId,
      this.empType,
      this.groupDepartmentUpdatedAt,
      this.memberLevel,
      this.expiredAt,
      this.scene,
      this.source,
      this.maxMember,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

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
    spaceId = json['space_id'];
    type = json['type'];
    login = json['login'];
    name = json['name'];
    description = json['description'];
    avatar = json['avatar'];
    ownerId = json['owner_id'];
    topicsCount = json['topics_count'];
    publicTopicsCount = json['public_topics_count'];
    membersCount = json['members_count'];
    booksCount = json['books_count'];
    publicBooksCount = json['public_books_count'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    accountId = json['account_id'];
    role = json['role'];
    status = json['status'];
    public = json['public'];
    wantsEmail = json['wants_email'];
    wantsMarketingEmail = json['wants_marketing_email'];
    topicUpdatedAtMs = json['topic_updated_at_ms'];
    deletedSlug = json['deleted_slug'];
    language = json['language'];
    organizationId = json['organization_id'];
    empType = json['emp_type'];
    groupDepartmentUpdatedAt = json['group_department_updated_at'];
    memberLevel = json['member_level'];
    expiredAt = json['expired_at'];
    scene = json['scene'];
    source = json['source'];
    maxMember = json['max_member'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
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
    data['space_id'] = this.spaceId;
    data['type'] = this.type;
    data['login'] = this.login;
    data['name'] = this.name;
    data['description'] = this.description;
    data['avatar'] = this.avatar;
    data['owner_id'] = this.ownerId;
    data['topics_count'] = this.topicsCount;
    data['public_topics_count'] = this.publicTopicsCount;
    data['members_count'] = this.membersCount;
    data['books_count'] = this.booksCount;
    data['public_books_count'] = this.publicBooksCount;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['account_id'] = this.accountId;
    data['role'] = this.role;
    data['status'] = this.status;
    data['public'] = this.public;
    data['wants_email'] = this.wantsEmail;
    data['wants_marketing_email'] = this.wantsMarketingEmail;
    data['topic_updated_at_ms'] = this.topicUpdatedAtMs;
    data['deleted_slug'] = this.deletedSlug;
    data['language'] = this.language;
    data['organization_id'] = this.organizationId;
    data['emp_type'] = this.empType;
    data['group_department_updated_at'] = this.groupDepartmentUpdatedAt;
    data['member_level'] = this.memberLevel;
    data['expired_at'] = this.expiredAt;
    data['scene'] = this.scene;
    data['source'] = this.source;
    data['max_member'] = this.maxMember;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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

class TargetBook {
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
  int public;
  String scene;
  String source;
  String createdAt;
  String updatedAt;
  String contentUpdatedAt;
  String pinnedAt;
  dynamic archivedAt;
  int status;
  int stackId;
  int rank;
  dynamic user;
  dynamic creator;
  String sSerializer;

  TargetBook(
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
      this.user,
      this.creator,
      this.sSerializer});

  TargetBook.fromJson(Map<String, dynamic> json) {
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
    user = json['user'];
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
    data['user'] = this.user;
    data['creator'] = this.creator;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
