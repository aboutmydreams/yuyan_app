class Unread {
  int count;
  List<UnreadNewsList> list;

  Unread({this.count, this.list});

  Unread.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<UnreadNewsList>();
      json['list'].forEach((v) {
        list.add(new UnreadNewsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnreadNewsList {
  int organizationId;
  String icon;
  String name;
  String host;
  int count;
  bool isSelf;

  UnreadNewsList(
      {this.organizationId,
      this.icon,
      this.name,
      this.host,
      this.count,
      this.isSelf});

  UnreadNewsList.fromJson(Map<String, dynamic> json) {
    organizationId = json['organization_id'];
    icon = json['icon'];
    name = json['name'];
    host = json['host'];
    count = json['count'];
    isSelf = json['isSelf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organization_id'] = this.organizationId;
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['host'] = this.host;
    data['count'] = this.count;
    data['isSelf'] = this.isSelf;
    return data;
  }
}

class NewsData {
  int normalCount;
  String listType;
  List<Notifications> notifications;

  NewsData({this.normalCount, this.listType, this.notifications});

  NewsData.fromJson(Map<String, dynamic> json) {
    normalCount = json['normalCount'];
    listType = json['list_type'];
    if (json['notifications'] != null) {
      notifications = new List<Notifications>();
      json['notifications'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['normalCount'] = this.normalCount;
    data['list_type'] = this.listType;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  dynamic params;
  int id;
  int spaceId;
  int organizationId;
  String notifyType;
  int userId;
  int actorId;
  String subjectType;
  int subjectId;
  String secondSubjectType;
  int secondSubjectId;
  ThirdSubject thirdSubject;
  dynamic thirdSubjectType;
  dynamic thirdSubjectId;
  dynamic readAt;
  String createdAt;
  String updatedAt;
  Actor actor;
  Subject subject;
  SecondSubject secondSubject;

  Notifications(
      {this.params,
      this.id,
      this.spaceId,
      this.organizationId,
      this.notifyType,
      this.userId,
      this.actorId,
      this.subjectType,
      this.subjectId,
      this.secondSubjectType,
      this.secondSubjectId,
      this.thirdSubject,
      this.thirdSubjectType,
      this.thirdSubjectId,
      this.readAt,
      this.createdAt,
      this.updatedAt,
      this.actor,
      this.subject,
      this.secondSubject});

  Notifications.fromJson(Map<String, dynamic> json) {
    params = json['params'];
    id = json['id'];
    spaceId = json['space_id'];
    organizationId = json['organization_id'];
    notifyType = json['notify_type'];
    userId = json['user_id'];
    actorId = json['actor_id'];
    subjectType = json['subject_type'];
    subjectId = json['subject_id'];
    secondSubjectType = json['second_subject_type'];
    secondSubjectId = json['second_subject_id'];
    thirdSubjectType = json['third_subject_type'];
    thirdSubjectId = json['third_subject_id'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    actor = json['actor'] != null ? new Actor.fromJson(json['actor']) : null;
    subject =
        json['subject'] != null ? new Subject.fromJson(json['subject']) : null;
    secondSubject = json['second_subject'] != null
        ? new SecondSubject.fromJson(json['second_subject'])
        : null;
    thirdSubject = json['third_subject'] != null
        ? new ThirdSubject.fromJson(json['third_subject'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['params'] = this.params;
    data['id'] = this.id;
    data['space_id'] = this.spaceId;
    data['organization_id'] = this.organizationId;
    data['notify_type'] = this.notifyType;
    data['user_id'] = this.userId;
    data['actor_id'] = this.actorId;
    data['subject_type'] = this.subjectType;
    data['subject_id'] = this.subjectId;
    data['second_subject_type'] = this.secondSubjectType;
    data['second_subject_id'] = this.secondSubjectId;
    data['third_subject_type'] = this.thirdSubjectType;
    data['third_subject_id'] = this.thirdSubjectId;
    data['third_subject'] = this.thirdSubject;
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.actor != null) {
      data['actor'] = this.actor.toJson();
    }
    if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
    if (this.secondSubject != null) {
      data['second_subject'] = this.secondSubject.toJson();
    }
    if (this.thirdSubject != null) {
      data['third_subject'] = this.thirdSubject.toJson();
    }
    return data;
  }
}

class Actor {
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

  Actor(
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

  Actor.fromJson(Map<String, dynamic> json) {
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
    ownerId = json['owner_id'] ?? 0;
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

class Subject {
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
  String scene;
  dynamic source;
  dynamic maxMember;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  int artboardGroupId;
  int bookId;
  dynamic assetId;
  dynamic assetVersionId;
  int userId;
  String md5;
  String uuid;
  int sort;
  String image;
  dynamic smallImage;
  dynamic labelMapUrl;
  int width;
  int height;
  int commentsCount;
  int likesCount;
  String contentUpdatedAt;
  Actor user;
  String body;
  String bodyAsl;
  String bodyDraft;
  String bodyDraftAsl;
  bool isSuspect;
  String slug;
  String title;
  dynamic tag;
  dynamic cover;
  dynamic customDescription;
  dynamic titleDraft;
  String format;
  int readStatus;
  int collaborationCount;
  int lastEditorId;
  int draftVersion;
  int wordCount;
  String publishedAt;
  String firstPublishedAt;
  dynamic selectedAt;
  String editorMeta;

  Subject(
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
      this.deletedAt,
      this.artboardGroupId,
      this.bookId,
      this.assetId,
      this.assetVersionId,
      this.userId,
      this.md5,
      this.uuid,
      this.sort,
      this.image,
      this.smallImage,
      this.labelMapUrl,
      this.width,
      this.height,
      this.commentsCount,
      this.likesCount,
      this.contentUpdatedAt,
      this.user,
      this.body,
      this.bodyAsl,
      this.bodyDraft,
      this.bodyDraftAsl,
      this.isSuspect,
      this.slug,
      this.title,
      this.tag,
      this.cover,
      this.customDescription,
      this.titleDraft,
      this.format,
      this.readStatus,
      this.collaborationCount,
      this.lastEditorId,
      this.draftVersion,
      this.wordCount,
      this.publishedAt,
      this.firstPublishedAt,
      this.selectedAt,
      this.editorMeta});

  Subject.fromJson(Map<String, dynamic> json) {
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
    artboardGroupId = json['artboard_group_id'];
    bookId = json['book_id'];
    assetId = json['asset_id'];
    assetVersionId = json['asset_version_id'];
    userId = json['user_id'];
    md5 = json['md5'];
    uuid = json['uuid'];
    sort = json['sort'];
    image = json['image'];
    smallImage = json['small_image'];
    labelMapUrl = json['label_map_url'];
    width = json['width'];
    height = json['height'];
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
    contentUpdatedAt = json['content_updated_at'];
    user = json['user'] != null ? new Actor.fromJson(json['user']) : null;
    body = json['body'];
    bodyAsl = json['body_asl'];
    bodyDraft = json['body_draft'];
    bodyDraftAsl = json['body_draft_asl'];
    isSuspect = json['isSuspect'];
    slug = json['slug'];
    title = json['title'];
    tag = json['tag'];
    cover = json['cover'];
    customDescription = json['custom_description'];
    titleDraft = json['title_draft'];
    format = json['format'];
    readStatus = json['read_status'];
    collaborationCount = json['collaboration_count'];
    lastEditorId = json['last_editor_id'];
    draftVersion = json['draft_version'];
    wordCount = json['word_count'];
    publishedAt = json['published_at'];
    firstPublishedAt = json['first_published_at'];
    selectedAt = json['selected_at'];
    editorMeta = json['editor_meta'];
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
    data['artboard_group_id'] = this.artboardGroupId;
    data['book_id'] = this.bookId;
    data['asset_id'] = this.assetId;
    data['asset_version_id'] = this.assetVersionId;
    data['user_id'] = this.userId;
    data['md5'] = this.md5;
    data['uuid'] = this.uuid;
    data['sort'] = this.sort;
    data['image'] = this.image;
    data['small_image'] = this.smallImage;
    data['label_map_url'] = this.labelMapUrl;
    data['width'] = this.width;
    data['height'] = this.height;
    data['comments_count'] = this.commentsCount;
    data['likes_count'] = this.likesCount;
    data['content_updated_at'] = this.contentUpdatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['body'] = this.body;
    data['body_asl'] = this.bodyAsl;
    data['body_draft'] = this.bodyDraft;
    data['body_draft_asl'] = this.bodyDraftAsl;
    data['isSuspect'] = this.isSuspect;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['tag'] = this.tag;
    data['cover'] = this.cover;
    data['custom_description'] = this.customDescription;
    data['title_draft'] = this.titleDraft;
    data['format'] = this.format;
    data['read_status'] = this.readStatus;
    data['collaboration_count'] = this.collaborationCount;
    data['last_editor_id'] = this.lastEditorId;
    data['draft_version'] = this.draftVersion;
    data['word_count'] = this.wordCount;
    data['published_at'] = this.publishedAt;
    data['first_published_at'] = this.firstPublishedAt;
    data['selected_at'] = this.selectedAt;
    data['editor_meta'] = this.editorMeta;
    return data;
  }
}

class SecondSubject {
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
  String title;
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
  dynamic scene;
  dynamic source;
  dynamic deletedAt;
  Actor user;

  SecondSubject(
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
      this.title,
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

  SecondSubject.fromJson(Map<String, dynamic> json) {
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
    name = json['title'];
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
    user = json['user'] != null ? new Actor.fromJson(json['user']) : null;
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
  dynamic accountId;
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
  dynamic expiredAt;
  String scene;
  dynamic source;
  int maxMember;
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

class ThirdSubject {
  int id;
  int spaceId;
  int artboardGroupId;
  int bookId;
  int assetId;
  int assetVersionId;
  int userId;
  String md5;
  String uuid;
  int sort;
  String image;
  dynamic smallImage;
  String labelMapUrl;
  String name;
  int width;
  int height;
  int commentsCount;
  int likesCount;
  String createdAt;
  String updatedAt;
  String contentUpdatedAt;
  dynamic deletedAt;
  User user;
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
  String type;
  String login;
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
  int maxMember;
  bool enableComment;
  bool enableExport;
  bool enableVisitorWatermark;
  String copyrightWatermark;
  String imageCopyrightWatermark;
  bool enableSearchEngine;
  bool enableWebhook;
  bool enableTrash;
  String slug;
  String toc;
  String tocYml;
  String body;
  int creatorId;
  int excellent;
  int menuType;
  int itemsCount;
  int watchesCount;
  int contentUpdatedAtMs;
  String pinnedAt;
  dynamic archivedAt;
  int collaborationCount;
  int stackId;
  int rank;
  int resourceSize;

  ThirdSubject(
      {this.id,
      this.spaceId,
      this.artboardGroupId,
      this.bookId,
      this.assetId,
      this.assetVersionId,
      this.userId,
      this.md5,
      this.uuid,
      this.sort,
      this.image,
      this.smallImage,
      this.labelMapUrl,
      this.name,
      this.width,
      this.height,
      this.commentsCount,
      this.likesCount,
      this.createdAt,
      this.updatedAt,
      this.contentUpdatedAt,
      this.deletedAt,
      this.user,
      this.workId,
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
      this.type,
      this.login,
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
      this.enableComment,
      this.enableExport,
      this.enableVisitorWatermark,
      this.copyrightWatermark,
      this.imageCopyrightWatermark,
      this.enableSearchEngine,
      this.enableWebhook,
      this.enableTrash,
      this.slug,
      this.toc,
      this.tocYml,
      this.body,
      this.creatorId,
      this.excellent,
      this.menuType,
      this.itemsCount,
      this.watchesCount,
      this.contentUpdatedAtMs,
      this.pinnedAt,
      this.archivedAt,
      this.collaborationCount,
      this.stackId,
      this.rank,
      this.resourceSize});

  ThirdSubject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    spaceId = json['space_id'];
    artboardGroupId = json['artboard_group_id'];
    bookId = json['book_id'];
    assetId = json['asset_id'];
    assetVersionId = json['asset_version_id'];
    userId = json['user_id'];
    md5 = json['md5'];
    uuid = json['uuid'];
    sort = json['sort'];
    image = json['image'];
    smallImage = json['small_image'];
    labelMapUrl = json['label_map_url'];
    name = json['name'];
    width = json['width'];
    height = json['height'];
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentUpdatedAt = json['content_updated_at'];
    deletedAt = json['deleted_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    type = json['type'];
    login = json['login'];
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
    enableComment = json['enable_comment'];
    enableExport = json['enable_export'];
    enableVisitorWatermark = json['enable_visitor_watermark'];
    copyrightWatermark = json['copyright_watermark'];
    imageCopyrightWatermark = json['image_copyright_watermark'];
    enableSearchEngine = json['enable_search_engine'];
    enableWebhook = json['enable_webhook'];
    enableTrash = json['enable_trash'];
    slug = json['slug'];
    toc = json['toc'];
    tocYml = json['toc_yml'];
    body = json['body'];
    creatorId = json['creator_id'];
    excellent = json['excellent'];
    menuType = json['menu_type'];
    itemsCount = json['items_count'];
    watchesCount = json['watches_count'];
    contentUpdatedAtMs = json['content_updated_at_ms'];
    pinnedAt = json['pinned_at'];
    archivedAt = json['archived_at'];
    collaborationCount = json['collaboration_count'];
    stackId = json['stack_id'];
    rank = json['rank'];
    resourceSize = json['resource_size'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['space_id'] = this.spaceId;
    data['artboard_group_id'] = this.artboardGroupId;
    data['book_id'] = this.bookId;
    data['asset_id'] = this.assetId;
    data['asset_version_id'] = this.assetVersionId;
    data['user_id'] = this.userId;
    data['md5'] = this.md5;
    data['uuid'] = this.uuid;
    data['sort'] = this.sort;
    data['image'] = this.image;
    data['small_image'] = this.smallImage;
    data['label_map_url'] = this.labelMapUrl;
    data['name'] = this.name;
    data['width'] = this.width;
    data['height'] = this.height;
    data['comments_count'] = this.commentsCount;
    data['likes_count'] = this.likesCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['content_updated_at'] = this.contentUpdatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
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
    data['type'] = this.type;
    data['login'] = this.login;
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
    data['enable_comment'] = this.enableComment;
    data['enable_export'] = this.enableExport;
    data['enable_visitor_watermark'] = this.enableVisitorWatermark;
    data['copyright_watermark'] = this.copyrightWatermark;
    data['image_copyright_watermark'] = this.imageCopyrightWatermark;
    data['enable_search_engine'] = this.enableSearchEngine;
    data['enable_webhook'] = this.enableWebhook;
    data['enable_trash'] = this.enableTrash;
    data['slug'] = this.slug;
    data['toc'] = this.toc;
    data['toc_yml'] = this.tocYml;
    data['body'] = this.body;
    data['creator_id'] = this.creatorId;
    data['excellent'] = this.excellent;
    data['menu_type'] = this.menuType;
    data['items_count'] = this.itemsCount;
    data['watches_count'] = this.watchesCount;
    data['content_updated_at_ms'] = this.contentUpdatedAtMs;
    data['pinned_at'] = this.pinnedAt;
    data['archived_at'] = this.archivedAt;
    data['collaboration_count'] = this.collaborationCount;
    data['stack_id'] = this.stackId;
    data['rank'] = this.rank;
    data['resource_size'] = this.resourceSize;
    return data;
  }
}
