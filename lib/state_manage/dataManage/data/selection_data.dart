class SelectionsData {
  List<Data> data;

  SelectionsData({this.data});

  SelectionsData.fromJson(Map<String, dynamic> json) {
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
  dynamic subType;
  String title;
  dynamic titleDraft;
  dynamic tag;
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
  String selectedAt;
  dynamic pinnedAt;
  Book book;
  User user;
  dynamic lastEditor;
  dynamic share;
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
      this.selectedAt,
      this.pinnedAt,
      this.book,
      this.user,
      this.lastEditor,
      this.share,
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
    selectedAt = json['selected_at'];
    pinnedAt = json['pinned_at'];
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    lastEditor = json['last_editor'];
    share = json['share'];
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
    data['selected_at'] = this.selectedAt;
    data['pinned_at'] = this.pinnedAt;

    if (this.book != null) {
      data['book'] = this.book.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['last_editor'] = this.lastEditor;
    data['share'] = this.share;
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
  int public;
  String createdAt;
  String updatedAt;
  String contentUpdatedAt;
  User user;
  dynamic creator;
  String sSerializer;

  Book(
      {this.id,
      this.type,
      this.slug,
      this.name,
      this.userId,
      this.description,
      this.public,
      this.createdAt,
      this.updatedAt,
      this.contentUpdatedAt,
      this.user,
      this.creator,
      this.sSerializer});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    slug = json['slug'];
    name = json['name'];
    userId = json['user_id'];
    description = json['description'];
    public = json['public'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentUpdatedAt = json['content_updated_at'];
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
    data['public'] = this.public;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['content_updated_at'] = this.contentUpdatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['creator'] = this.creator;
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
  String avatarUrl;
  int public;
  String scene;
  String createdAt;
  String updatedAt;
  int organizationId;
  bool isPaid;
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
