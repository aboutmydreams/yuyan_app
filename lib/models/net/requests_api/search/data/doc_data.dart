class SearchDocJson {
  SearchDocData data;

  SearchDocJson({this.data});

  SearchDocJson.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new SearchDocData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class SearchDocData {
  String type;
  List<Hits> hits;
  int totalHits;
  int numHits;

  SearchDocData({this.type, this.hits, this.totalHits, this.numHits});

  SearchDocData.fromJson(Map<String, dynamic> json) {
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
  String title;
  String slug;
  String url;
  Record rRecord;

  Hits(
      {this.id,
      this.type,
      this.abstract,
      this.bookName,
      this.groupName,
      this.title,
      this.slug,
      this.url,
      this.rRecord});

  Hits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    abstract = json['abstract'];
    bookName = json['book_name'];
    groupName = json['group_name'];
    title = json['title'];
    slug = json['slug'];
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
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['url'] = this.url;
    if (this.rRecord != null) {
      data['_record'] = this.rRecord.toJson();
    }
    return data;
  }
}

class Record {
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
  dynamic titleDraft;
  String format;
  int status;
  int readStatus;
  int viewStatus;
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
  dynamic selectedAt;
  dynamic pinnedAt;
  String editorMeta;
  dynamic deletedAt;
  Book book;

  Record(
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
      this.viewStatus,
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
      this.pinnedAt,
      this.editorMeta,
      this.deletedAt,
      this.book});

  Record.fromJson(Map<String, dynamic> json) {
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
    viewStatus = json['view_status'];
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
    pinnedAt = json['pinned_at'];
    editorMeta = json['editor_meta'];
    deletedAt = json['deleted_at'];
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
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
    data['view_status'] = this.viewStatus;
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
    data['pinned_at'] = this.pinnedAt;
    data['editor_meta'] = this.editorMeta;
    data['deleted_at'] = this.deletedAt;
    if (this.book != null) {
      data['book'] = this.book.toJson();
    }
    return data;
  }
}

class Book {
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
  String type;
  String name;
  String slug;
  String description;
  int userId;
  int public;
  String createdAt;
  String updatedAt;
  User user;

  Book(
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
      this.type,
      this.name,
      this.slug,
      this.description,
      this.userId,
      this.public,
      this.createdAt,
      this.updatedAt,
      this.user});

  Book.fromJson(Map<String, dynamic> json) {
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
    type = json['type'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    userId = json['user_id'];
    public = json['public'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['type'] = this.type;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['public'] = this.public;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  dynamic expiredAt;
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
