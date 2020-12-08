class GroupHomeJson {
  List<Data> data;

  GroupHomeJson({this.data});

  GroupHomeJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int id;
  String createdAt;
  String updatedAt;
  int userId;
  int displayType;
  String name;
  int rank;
  bool isDefault;
  List<Books> books;
  String sSerializer;

  Data(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.displayType,
      this.name,
      this.rank,
      this.isDefault,
      this.books,
      this.sSerializer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    displayType = json['display_type'];
    name = json['name'];
    rank = json['rank'];
    isDefault = json['is_default'];
    if (json['books'] != null) {
      books = new List<Books>();
      json['books'].forEach((v) {
        books.add(new Books.fromJson(v));
      });
    }
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['display_type'] = this.displayType;
    data['name'] = this.name;
    data['rank'] = this.rank;
    data['is_default'] = this.isDefault;
    if (this.books != null) {
      data['books'] = this.books.map((v) => v.toJson()).toList();
    }
    data['_serializer'] = this.sSerializer;
    return data;
  }
}

class Books {
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
  dynamic scene;
  dynamic source;
  String createdAt;
  String updatedAt;
  String contentUpdatedAt;
  String pinnedAt;
  dynamic archivedAt;
  List<Summary> summary;
  int status;
  int stackId;
  int rank;
  String layout;
  String docViewport;
  String docTypography;
  BookIcon bookIcon;
  String cover;
  User user;
  dynamic creator;
  String sSerializer;

  Books(
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
      this.summary,
      this.status,
      this.stackId,
      this.rank,
      this.layout,
      this.docViewport,
      this.docTypography,
      this.bookIcon,
      this.cover,
      this.user,
      this.creator,
      this.sSerializer});

  Books.fromJson(Map<String, dynamic> json) {
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
    if (json['summary'] != null) {
      summary = new List<Summary>();
      json['summary'].forEach((v) {
        summary.add(new Summary.fromJson(v));
      });
    }
    status = json['status'];
    stackId = json['stack_id'];
    rank = json['rank'];
    layout = json['layout'];
    docViewport = json['doc_viewport'];
    docTypography = json['doc_typography'];
    bookIcon = json['book_icon'] != null
        ? new BookIcon.fromJson(json['book_icon'])
        : null;
    cover = json['cover'];
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
    if (this.summary != null) {
      data['summary'] = this.summary.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['stack_id'] = this.stackId;
    data['rank'] = this.rank;
    data['layout'] = this.layout;
    data['doc_viewport'] = this.docViewport;
    data['doc_typography'] = this.docTypography;
    if (this.bookIcon != null) {
      data['book_icon'] = this.bookIcon.toJson();
    }
    data['cover'] = this.cover;
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

class Summary {
  Meta meta;
  String contentUpdatedAt;
  String body;
  String bodyAsl;
  String bodyDraft;
  String bodyDraftAsl;
  String premiumBody;
  String premiumBodyAsl;
  String premiumBodyDraft;
  String premiumBodyDraftAsl;
  bool isSuspect;
  String fullBody;
  String fullBodyAsl;
  String fullBodyDraft;
  String fullBodyDraftAsl;
  String editorMeta;
  String editorMetaDraft;
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
  dynamic premiumDaysCount;
  dynamic premiumPrice;
  dynamic premiumStartedAt;
  dynamic premiumExpiredAt;
  String docMeta;
  String docMetaDraft;
  String image;
  dynamic deletedAt;

  Summary(
      {this.meta,
      this.contentUpdatedAt,
      this.body,
      this.bodyAsl,
      this.bodyDraft,
      this.bodyDraftAsl,
      this.premiumBody,
      this.premiumBodyAsl,
      this.premiumBodyDraft,
      this.premiumBodyDraftAsl,
      this.isSuspect,
      this.fullBody,
      this.fullBodyAsl,
      this.fullBodyDraft,
      this.fullBodyDraftAsl,
      this.editorMeta,
      this.editorMetaDraft,
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
      this.premiumDaysCount,
      this.premiumPrice,
      this.premiumStartedAt,
      this.premiumExpiredAt,
      this.docMeta,
      this.docMetaDraft,
      this.image,
      this.deletedAt});

  Summary.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    contentUpdatedAt = json['content_updated_at'];
    body = json['body'];
    bodyAsl = json['body_asl'];
    bodyDraft = json['body_draft'];
    bodyDraftAsl = json['body_draft_asl'];
    premiumBody = json['premium_body'];
    premiumBodyAsl = json['premium_body_asl'];
    premiumBodyDraft = json['premium_body_draft'];
    premiumBodyDraftAsl = json['premium_body_draft_asl'];
    isSuspect = json['isSuspect'];
    fullBody = json['full_body'];
    fullBodyAsl = json['full_body_asl'];
    fullBodyDraft = json['full_body_draft'];
    fullBodyDraftAsl = json['full_body_draft_asl'];
    editorMeta = json['editor_meta'];
    editorMetaDraft = json['editor_meta_draft'];
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
    premiumDaysCount = json['premium_days_count'];
    premiumPrice = json['premium_price'];
    premiumStartedAt = json['premium_started_at'];
    premiumExpiredAt = json['premium_expired_at'];
    docMeta = json['doc_meta'];
    docMetaDraft = json['doc_meta_draft'];
    image = json['image'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    data['content_updated_at'] = this.contentUpdatedAt;
    data['body'] = this.body;
    data['body_asl'] = this.bodyAsl;
    data['body_draft'] = this.bodyDraft;
    data['body_draft_asl'] = this.bodyDraftAsl;
    data['premium_body'] = this.premiumBody;
    data['premium_body_asl'] = this.premiumBodyAsl;
    data['premium_body_draft'] = this.premiumBodyDraft;
    data['premium_body_draft_asl'] = this.premiumBodyDraftAsl;
    data['isSuspect'] = this.isSuspect;
    data['full_body'] = this.fullBody;
    data['full_body_asl'] = this.fullBodyAsl;
    data['full_body_draft'] = this.fullBodyDraft;
    data['full_body_draft_asl'] = this.fullBodyDraftAsl;
    data['editor_meta'] = this.editorMeta;
    data['editor_meta_draft'] = this.editorMetaDraft;
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
    data['premium_days_count'] = this.premiumDaysCount;
    data['premium_price'] = this.premiumPrice;
    data['premium_started_at'] = this.premiumStartedAt;
    data['premium_expired_at'] = this.premiumExpiredAt;
    data['doc_meta'] = this.docMeta;
    data['doc_meta_draft'] = this.docMetaDraft;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Meta {
  int showAuthorOption;
  int showAuthorId;

  Meta({this.showAuthorOption, this.showAuthorId});

  Meta.fromJson(Map<String, dynamic> json) {
    showAuthorOption = json['show_author_option'];
    showAuthorId = json['show_author_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['show_author_option'] = this.showAuthorOption;
    data['show_author_id'] = this.showAuthorId;
    return data;
  }
}

class BookIcon {
  String type;
  String symbol;
  String color;

  BookIcon({this.type, this.symbol, this.color});

  BookIcon.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    symbol = json['symbol'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['symbol'] = this.symbol;
    data['color'] = this.color;
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
  dynamic scene;
  String createdAt;
  String updatedAt;
  int organizationId;
  bool isPaid;
  int memberLevel;
  dynamic organization;
  dynamic owners;
  String sSerializer;

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
      this.sSerializer});

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
    return data;
  }
}
