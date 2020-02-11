class GroupHomeJson {
  Meta meta;
  HomeData data;

  GroupHomeJson({this.meta, this.data});

  GroupHomeJson.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    data = json['data'] != null ? new HomeData.fromJson(json['data']) : null;
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
  Layout layout;

  Meta({this.layout});

  Meta.fromJson(Map<String, dynamic> json) {
    layout =
        json['layout'] != null ? new Layout.fromJson(json['layout']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.layout != null) {
      data['layout'] = this.layout.toJson();
    }
    return data;
  }
}

class Layout {
  List<String> header;
  List<String> content;
  List<String> aside;

  Layout({this.header, this.content, this.aside});

  Layout.fromJson(Map<String, dynamic> json) {
    header = json['header'].cast<String>();
    content = json['content'].cast<String>();
    aside = json['aside'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['header'] = this.header;
    data['content'] = this.content;
    data['aside'] = this.aside;
    return data;
  }
}

class HomeData {
  List<Headlines> headlines;
  List<BookStacks> bookStacks;
  List<Members> members;

  HomeData({this.headlines, this.bookStacks, this.members});

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['headlines'] != null) {
      headlines = new List<Headlines>();
      json['headlines'].forEach((v) {
        headlines.add(new Headlines.fromJson(v));
      });
    }
    if (json['book_stacks'] != null) {
      bookStacks = new List<BookStacks>();
      json['book_stacks'].forEach((v) {
        bookStacks.add(new BookStacks.fromJson(v));
      });
    }
    if (json['members'] != null) {
      members = new List<Members>();
      json['members'].forEach((v) {
        members.add(new Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.headlines != null) {
      data['headlines'] = this.headlines.map((v) => v.toJson()).toList();
    }
    if (this.bookStacks != null) {
      data['book_stacks'] = this.bookStacks.map((v) => v.toJson()).toList();
    }
    if (this.members != null) {
      data['members'] = this.members.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Headlines {
  int id;
  String createdAt;
  String updatedAt;
  int userId;
  String title;
  String url;
  String cover;
  int rank;
  String description;
  String sSerializer;

  Headlines(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.title,
      this.url,
      this.cover,
      this.rank,
      this.description,
      this.sSerializer});

  Headlines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    title = json['title'];
    url = json['url'];
    cover = json['cover'];
    rank = json['rank'];
    description = json['description'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['url'] = this.url;
    data['cover'] = this.cover;
    data['rank'] = this.rank;
    data['description'] = this.description;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}

class BookStacks {
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

  BookStacks(
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

  BookStacks.fromJson(Map<String, dynamic> json) {
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

  Abilities({this.read});

  Abilities.fromJson(Map<String, dynamic> json) {
    read = json['read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['read'] = this.read;
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
  bool isSuspect;
  int id;
  int spaceId;
  String type;
  String subType;
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
  String selectedAt;
  dynamic pinnedAt;
  String editorMeta;
  dynamic deletedAt;

  Summary(
      {this.meta,
      this.contentUpdatedAt,
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
      this.deletedAt});

  Summary.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
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
  int ownerId;
  int booksCount;
  int publicBooksCount;
  int topicsCount;
  int publicTopicsCount;
  int membersCount;
  int public;
  dynamic scene;
  String createdAt;
  String updatedAt;
  int organizationId;
  bool isPaid;
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

  User.fromJson(Map<String, dynamic> json) {
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

class Members {
  int id;
  int userId;
  int groupId;
  int role;
  int status;
  dynamic departmentName;
  String createdAt;
  String updatedAt;
  String pinnedAt;
  dynamic user;
  dynamic group;
  String sSerializer;

  Members(
      {this.id,
      this.userId,
      this.groupId,
      this.role,
      this.status,
      this.departmentName,
      this.createdAt,
      this.updatedAt,
      this.pinnedAt,
      this.user,
      this.group,
      this.sSerializer});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    groupId = json['group_id'];
    role = json['role'];
    status = json['status'];
    departmentName = json['department_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pinnedAt = json['pinned_at'];
    user = json['user'];
    group = json['group'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['group_id'] = this.groupId;
    data['role'] = this.role;
    data['status'] = this.status;
    data['department_name'] = this.departmentName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['pinned_at'] = this.pinnedAt;
    data['user'] = this.user;
    data['group'] = this.group;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
