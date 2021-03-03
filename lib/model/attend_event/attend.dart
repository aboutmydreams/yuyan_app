class TestJson {
  Meta meta;
  List<Data> data;

  TestJson({this.meta, this.data});

  TestJson.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  bool hasMore;

  Meta({this.hasMore});

  Meta.fromJson(Map<String, dynamic> json) {
    hasMore = json['hasMore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasMore'] = this.hasMore;
    return data;
  }
}

class Data {
  int id;
  int spaceId;
  int userId;
  int organizationId;
  String eventType;
  String subjectType;
  int subjectId;
  String secondSubjectType;
  int secondSubjectId;
  String thirdSubjectType;
  int thirdSubjectId;
  int actorId;
  int bookId;
  Params params;
  String createdAt;
  String updatedAt;
  Subject subject;
  SecondSubject secondSubject;
  ThirdSubject thirdSubject;
  ThirdSubject actor;
  Book book;
  String sSerializer;

  Data(
      {this.id,
      this.spaceId,
      this.userId,
      this.organizationId,
      this.eventType,
      this.subjectType,
      this.subjectId,
      this.secondSubjectType,
      this.secondSubjectId,
      this.thirdSubjectType,
      this.thirdSubjectId,
      this.actorId,
      this.bookId,
      this.params,
      this.createdAt,
      this.updatedAt,
      this.subject,
      this.secondSubject,
      this.thirdSubject,
      this.actor,
      this.book,
      this.sSerializer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    spaceId = json['space_id'];
    userId = json['user_id'];
    organizationId = json['organization_id'];
    eventType = json['event_type'];
    subjectType = json['subject_type'];
    subjectId = json['subject_id'];
    secondSubjectType = json['second_subject_type'];
    secondSubjectId = json['second_subject_id'];
    thirdSubjectType = json['third_subject_type'];
    thirdSubjectId = json['third_subject_id'];
    actorId = json['actor_id'];
    bookId = json['book_id'];
    params =
        json['params'] != null ? new Params.fromJson(json['params']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subject =
        json['subject'] != null ? new Subject.fromJson(json['subject']) : null;
    secondSubject = json['second_subject'] != null
        ? new SecondSubject.fromJson(json['second_subject'])
        : null;
    thirdSubject = json['third_subject'] != null
        ? new ThirdSubject.fromJson(json['third_subject'])
        : null;
    actor =
        json['actor'] != null ? new ThirdSubject.fromJson(json['actor']) : null;
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['space_id'] = this.spaceId;
    data['user_id'] = this.userId;
    data['organization_id'] = this.organizationId;
    data['event_type'] = this.eventType;
    data['subject_type'] = this.subjectType;
    data['subject_id'] = this.subjectId;
    data['second_subject_type'] = this.secondSubjectType;
    data['second_subject_id'] = this.secondSubjectId;
    data['third_subject_type'] = this.thirdSubjectType;
    data['third_subject_id'] = this.thirdSubjectId;
    data['actor_id'] = this.actorId;
    data['book_id'] = this.bookId;
    if (this.params != null) {
      data['params'] = this.params.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subject != null) {
      data['subject'] = this.subject.toJson();
    }
    if (this.secondSubject != null) {
      data['second_subject'] = this.secondSubject.toJson();
    }
    if (this.thirdSubject != null) {
      data['third_subject'] = this.thirdSubject.toJson();
    }
    if (this.actor != null) {
      data['actor'] = this.actor.toJson();
    }
    if (this.book != null) {
      data['book'] = this.book.toJson();
    }
    data['_serializer'] = this.sSerializer;
    return data;
  }
}

class Params {
  int count;
  List<Artboards> artboards;

  Params({this.count, this.artboards});

  Params.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['artboards'] != null) {
      artboards = new List<Artboards>();
      json['artboards'].forEach((v) {
        artboards.add(new Artboards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.artboards != null) {
      data['artboards'] = this.artboards.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Artboards {
  int id;
  String name;
  String image;

  Artboards({this.id, this.name, this.image});

  Artboards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Subject {
  int id;
  int spaceId;
  String type;
  Null subType;
  String title;
  Null titleDraft;
  Null tag;
  String slug;
  int userId;
  int bookId;
  int lastEditorId;
  String cover;
  String description;
  String customDescription;
  String format;
  int status;
  int readStatus;
  int public;
  int draftVersion;
  int commentsCount;
  int likesCount;
  String contentUpdatedAt;
  String createdAt;
  String updatedAt;
  String publishedAt;
  String firstPublishedAt;
  int wordCount;
  User user;
  Null lastEditor;
  String sSerializer;
  String name;
  int itemsCount;
  int watchesCount;
  int creatorId;
  String login;
  String avatar;
  Null scene;
  String avatarUrl;
  int role;
  bool isPaid;
  int memberLevel;
  int followersCount;
  int followingCount;

  Subject(
      {this.id,
      this.spaceId,
      this.type,
      this.subType,
      this.title,
      this.titleDraft,
      this.tag,
      this.slug,
      this.userId,
      this.bookId,
      this.lastEditorId,
      this.cover,
      this.description,
      this.customDescription,
      this.format,
      this.status,
      this.readStatus,
      this.public,
      this.draftVersion,
      this.commentsCount,
      this.likesCount,
      this.contentUpdatedAt,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.firstPublishedAt,
      this.wordCount,
      this.user,
      this.lastEditor,
      this.sSerializer,
      this.name,
      this.itemsCount,
      this.watchesCount,
      this.creatorId,
      this.login,
      this.avatar,
      this.scene,
      this.avatarUrl,
      this.role,
      this.isPaid,
      this.memberLevel,
      this.followersCount,
      this.followingCount});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    spaceId = json['space_id'];
    type = json['type'];
    subType = json['sub_type'];
    title = json['title'];
    titleDraft = json['title_draft'];
    tag = json['tag'];
    slug = json['slug'];
    userId = json['user_id'];
    bookId = json['book_id'];
    lastEditorId = json['last_editor_id'];
    cover = json['cover'];
    description = json['description'];
    customDescription = json['custom_description'];
    format = json['format'];
    status = json['status'];
    readStatus = json['read_status'];
    public = json['public'];
    draftVersion = json['draft_version'];
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
    contentUpdatedAt = json['content_updated_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    publishedAt = json['published_at'];
    firstPublishedAt = json['first_published_at'];
    wordCount = json['word_count'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    lastEditor = json['last_editor'];
    sSerializer = json['_serializer'];
    name = json['name'];
    itemsCount = json['items_count'];
    watchesCount = json['watches_count'];
    creatorId = json['creator_id'];
    login = json['login'];
    avatar = json['avatar'];
    scene = json['scene'];
    avatarUrl = json['avatar_url'];
    role = json['role'];
    isPaid = json['isPaid'];
    memberLevel = json['member_level'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['space_id'] = this.spaceId;
    data['type'] = this.type;
    data['sub_type'] = this.subType;
    data['title'] = this.title;
    data['title_draft'] = this.titleDraft;
    data['tag'] = this.tag;
    data['slug'] = this.slug;
    data['user_id'] = this.userId;
    data['book_id'] = this.bookId;
    data['last_editor_id'] = this.lastEditorId;
    data['cover'] = this.cover;
    data['description'] = this.description;
    data['custom_description'] = this.customDescription;
    data['format'] = this.format;
    data['status'] = this.status;
    data['read_status'] = this.readStatus;
    data['public'] = this.public;
    data['draft_version'] = this.draftVersion;
    data['comments_count'] = this.commentsCount;
    data['likes_count'] = this.likesCount;
    data['content_updated_at'] = this.contentUpdatedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['published_at'] = this.publishedAt;
    data['first_published_at'] = this.firstPublishedAt;
    data['word_count'] = this.wordCount;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['last_editor'] = this.lastEditor;
    data['_serializer'] = this.sSerializer;
    data['name'] = this.name;
    data['items_count'] = this.itemsCount;
    data['watches_count'] = this.watchesCount;
    data['creator_id'] = this.creatorId;
    data['login'] = this.login;
    data['avatar'] = this.avatar;
    data['scene'] = this.scene;
    data['avatar_url'] = this.avatarUrl;
    data['role'] = this.role;
    data['isPaid'] = this.isPaid;
    data['member_level'] = this.memberLevel;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    return data;
  }
}

class User {
  int id;
  String type;
  String login;
  String name;
  String avatar;
  Null scene;
  String avatarUrl;
  int role;
  bool isPaid;
  int memberLevel;
  int followersCount;
  int followingCount;
  String description;
  String sSerializer;
  int ownerId;
  int booksCount;
  int publicBooksCount;
  int topicsCount;
  int publicTopicsCount;
  int membersCount;
  int public;
  String createdAt;
  String updatedAt;
  int organizationId;
  int grainsSum;
  Null organization;
  Null owners;

  User(
      {this.id,
      this.type,
      this.login,
      this.name,
      this.avatar,
      this.scene,
      this.avatarUrl,
      this.role,
      this.isPaid,
      this.memberLevel,
      this.followersCount,
      this.followingCount,
      this.description,
      this.sSerializer,
      this.ownerId,
      this.booksCount,
      this.publicBooksCount,
      this.topicsCount,
      this.publicTopicsCount,
      this.membersCount,
      this.public,
      this.createdAt,
      this.updatedAt,
      this.organizationId,
      this.grainsSum,
      this.organization,
      this.owners});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    login = json['login'];
    name = json['name'];
    avatar = json['avatar'];
    scene = json['scene'];
    avatarUrl = json['avatar_url'];
    role = json['role'];
    isPaid = json['isPaid'];
    memberLevel = json['member_level'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    description = json['description'];
    sSerializer = json['_serializer'];
    ownerId = json['owner_id'];
    booksCount = json['books_count'];
    publicBooksCount = json['public_books_count'];
    topicsCount = json['topics_count'];
    publicTopicsCount = json['public_topics_count'];
    membersCount = json['members_count'];
    public = json['public'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    organizationId = json['organization_id'];
    grainsSum = json['grains_sum'];
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
    data['scene'] = this.scene;
    data['avatar_url'] = this.avatarUrl;
    data['role'] = this.role;
    data['isPaid'] = this.isPaid;
    data['member_level'] = this.memberLevel;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['description'] = this.description;
    data['_serializer'] = this.sSerializer;
    data['owner_id'] = this.ownerId;
    data['books_count'] = this.booksCount;
    data['public_books_count'] = this.publicBooksCount;
    data['topics_count'] = this.topicsCount;
    data['public_topics_count'] = this.publicTopicsCount;
    data['members_count'] = this.membersCount;
    data['public'] = this.public;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['organization_id'] = this.organizationId;
    data['grains_sum'] = this.grainsSum;
    data['organization'] = this.organization;
    data['owners'] = this.owners;
    return data;
  }
}

class SecondSubject {
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
  String createdAt;
  String updatedAt;
  String contentUpdatedAt;
  User user;
  String sSerializer;
  String login;
  String avatar;
  Null scene;
  String avatarUrl;
  int role;
  bool isPaid;
  int memberLevel;
  int followersCount;
  int followingCount;
  int bookId;
  Null uuid;
  int sort;
  String artboardType;
  Null sourceFile;
  Null pinnedAt;
  Null artboards;

  SecondSubject(
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
      this.createdAt,
      this.updatedAt,
      this.contentUpdatedAt,
      this.user,
      this.sSerializer,
      this.login,
      this.avatar,
      this.scene,
      this.avatarUrl,
      this.role,
      this.isPaid,
      this.memberLevel,
      this.followersCount,
      this.followingCount,
      this.bookId,
      this.uuid,
      this.sort,
      this.artboardType,
      this.sourceFile,
      this.pinnedAt,
      this.artboards});

  SecondSubject.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentUpdatedAt = json['content_updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    sSerializer = json['_serializer'];
    login = json['login'];
    avatar = json['avatar'];
    scene = json['scene'];
    avatarUrl = json['avatar_url'];
    role = json['role'];
    isPaid = json['isPaid'];
    memberLevel = json['member_level'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    bookId = json['book_id'];
    uuid = json['uuid'];
    sort = json['sort'];
    artboardType = json['artboard_type'];
    sourceFile = json['source_file'];
    pinnedAt = json['pinned_at'];
    artboards = json['artboards'];
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['content_updated_at'] = this.contentUpdatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['_serializer'] = this.sSerializer;
    data['login'] = this.login;
    data['avatar'] = this.avatar;
    data['scene'] = this.scene;
    data['avatar_url'] = this.avatarUrl;
    data['role'] = this.role;
    data['isPaid'] = this.isPaid;
    data['member_level'] = this.memberLevel;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['book_id'] = this.bookId;
    data['uuid'] = this.uuid;
    data['sort'] = this.sort;
    data['artboard_type'] = this.artboardType;
    data['source_file'] = this.sourceFile;
    data['pinned_at'] = this.pinnedAt;
    data['artboards'] = this.artboards;
    return data;
  }
}

class ThirdSubject {
  int id;
  String type;
  String login;
  String name;
  String avatar;
  Null scene;
  String avatarUrl;
  int role;
  bool isPaid;
  int memberLevel;
  int followersCount;
  int followingCount;
  String description;
  String sSerializer;

  ThirdSubject(
      {this.id,
      this.type,
      this.login,
      this.name,
      this.avatar,
      this.scene,
      this.avatarUrl,
      this.role,
      this.isPaid,
      this.memberLevel,
      this.followersCount,
      this.followingCount,
      this.description,
      this.sSerializer});

  ThirdSubject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    login = json['login'];
    name = json['name'];
    avatar = json['avatar'];
    scene = json['scene'];
    avatarUrl = json['avatar_url'];
    role = json['role'];
    isPaid = json['isPaid'];
    memberLevel = json['member_level'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    description = json['description'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['login'] = this.login;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['scene'] = this.scene;
    data['avatar_url'] = this.avatarUrl;
    data['role'] = this.role;
    data['isPaid'] = this.isPaid;
    data['member_level'] = this.memberLevel;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['description'] = this.description;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}

class Book {
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
  String createdAt;
  String updatedAt;
  String contentUpdatedAt;
  User user;
  String sSerializer;

  Book(
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
      this.createdAt,
      this.updatedAt,
      this.contentUpdatedAt,
      this.user,
      this.sSerializer});

  Book.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentUpdatedAt = json['content_updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['content_updated_at'] = this.contentUpdatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
