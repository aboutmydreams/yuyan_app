class DocBookJson {
  List<Data> data;

  DocBookJson({this.data});

  DocBookJson.fromJson(Map<String, dynamic> json) {
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
  int spaceId;
  String type;
  String subType;
  String title;
  String titleDraft;
  String tag;
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
  int viewStatus;
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
  int hits;
  List<Contributors> contributors;
  dynamic selectedAt;
  dynamic pinnedAt;
  dynamic book;
  User user;
  String lastEditor;
  String share;
  bool isPreimum;
  String sSerializer;

  Data(
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
      this.viewStatus,
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
      this.hits,
      this.contributors,
      this.selectedAt,
      this.pinnedAt,
      this.book,
      this.user,
      this.lastEditor,
      this.share,
      this.isPreimum,
      this.sSerializer});

  Data.fromJson(Map<String, dynamic> json) {
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
    viewStatus = json['view_status'];
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
    hits = json['hits'];
    if (json['contributors'] != null) {
      contributors = new List<Contributors>();
      json['contributors'].forEach((v) {
        contributors.add(new Contributors.fromJson(v));
      });
    }
    selectedAt = json['selected_at'];
    pinnedAt = json['pinned_at'];
    book = json['book'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    lastEditor = json['last_editor'];
    share = json['share'];
    isPreimum = json['isPreimum'];
    sSerializer = json['_serializer'];
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
    data['view_status'] = this.viewStatus;
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
    data['hits'] = this.hits;
    if (this.contributors != null) {
      data['contributors'] = this.contributors.map((v) => v.toJson()).toList();
    }
    data['selected_at'] = this.selectedAt;
    data['pinned_at'] = this.pinnedAt;
    data['book'] = this.book;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['last_editor'] = this.lastEditor;
    data['share'] = this.share;
    data['isPreimum'] = this.isPreimum;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}

class Contributors {
  int id;
  String type;
  String login;
  String description;
  String name;
  String avatar;
  String scene;
  String avatarUrl;
  int followersCount;
  int followingCount;
  int role;
  String createdAt;
  String updatedAt;
  bool isPaid;
  int memberLevel;
  String sSerializer;

  Contributors(
      {this.id,
      this.type,
      this.login,
      this.description,
      this.name,
      this.avatar,
      this.scene,
      this.avatarUrl,
      this.followersCount,
      this.followingCount,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.isPaid,
      this.memberLevel,
      this.sSerializer});

  Contributors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    login = json['login'];
    description = json['description'];
    name = json['name'];
    avatar = json['avatar'];
    scene = json['scene'];
    avatarUrl = json['avatar_url'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isPaid = json['isPaid'];
    memberLevel = json['member_level'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['login'] = this.login;
    data['description'] = this.description;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['scene'] = this.scene;
    data['avatar_url'] = this.avatarUrl;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['isPaid'] = this.isPaid;
    data['member_level'] = this.memberLevel;
    data['_serializer'] = this.sSerializer;
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
  String scene;
  String createdAt;
  String updatedAt;
  bool isPaid;
  int memberLevel;
  String profile;
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
