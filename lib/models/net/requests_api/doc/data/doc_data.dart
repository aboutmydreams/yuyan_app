class DocDatas {
  Meta meta;
  DocData data;

  DocDatas({this.meta, this.data});

  DocDatas.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    data = json['data'] != null ? new DocData.fromJson(json['data']) : null;
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
  bool marked;
  Abilities abilities;

  Meta({this.marked, this.abilities});

  Meta.fromJson(Map<String, dynamic> json) {
    marked = json['marked'];
    abilities = json['abilities'] != null
        ? new Abilities.fromJson(json['abilities'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marked'] = this.marked;
    if (this.abilities != null) {
      data['abilities'] = this.abilities.toJson();
    }
    return data;
  }
}

class Abilities {
  bool create;
  bool destroy;
  bool update;
  bool read;
  bool readOrigin;
  bool export;
  bool manage;
  bool join;
  bool share;
  bool forceDelete;
  bool createCollaborator;
  bool destroyComment;

  Abilities(
      {this.create,
      this.destroy,
      this.update,
      this.read,
      this.readOrigin,
      this.export,
      this.manage,
      this.join,
      this.share,
      this.forceDelete,
      this.createCollaborator,
      this.destroyComment});

  Abilities.fromJson(Map<String, dynamic> json) {
    create = json['create'];
    destroy = json['destroy'];
    update = json['update'];
    read = json['read'];
    readOrigin = json['read_origin'];
    export = json['export'];
    manage = json['manage'];
    join = json['join'];
    share = json['share'];
    forceDelete = json['force_delete'];
    createCollaborator = json['create_collaborator'];
    destroyComment = json['destroy_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create'] = this.create;
    data['destroy'] = this.destroy;
    data['update'] = this.update;
    data['read'] = this.read;
    data['read_origin'] = this.readOrigin;
    data['export'] = this.export;
    data['manage'] = this.manage;
    data['join'] = this.join;
    data['share'] = this.share;
    data['force_delete'] = this.forceDelete;
    data['create_collaborator'] = this.createCollaborator;
    data['destroy_comment'] = this.destroyComment;
    return data;
  }
}

class DocData {
  int id;
  int spaceId;
  String type;
  String title;
  dynamic tag;
  String slug;
  int userId;
  int bookId;
  dynamic cover;
  String description;
  dynamic customDescription;
  String bodyAsl;
  String format;
  int status;
  int readStatus;
  int public;
  int draftVersion;
  int commentsCount;
  int likesCount;
  Abilities abilities;
  String contentUpdatedAt;
  String createdAt;
  String updatedAt;
  String publishedAt;
  dynamic firstPublishedAt;
  int wordCount;
  String content;
  dynamic selectedAt;
  dynamic book;
  User user;
  User lastEditor;
  dynamic share;
  dynamic joinToken;
  String sSerializer;

  DocData(
      {this.id,
      this.spaceId,
      this.type,
      this.title,
      this.tag,
      this.slug,
      this.userId,
      this.bookId,
      this.cover,
      this.description,
      this.customDescription,
      this.bodyAsl,
      this.format,
      this.status,
      this.readStatus,
      this.public,
      this.draftVersion,
      this.commentsCount,
      this.likesCount,
      this.abilities,
      this.contentUpdatedAt,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.firstPublishedAt,
      this.wordCount,
      this.content,
      this.selectedAt,
      this.book,
      this.user,
      this.lastEditor,
      this.share,
      this.joinToken,
      this.sSerializer});

  DocData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    spaceId = json['space_id'];
    type = json['type'];
    title = json['title'];
    tag = json['tag'];
    slug = json['slug'];
    userId = json['user_id'];
    bookId = json['book_id'];
    cover = json['cover'];
    description = json['description'];
    customDescription = json['custom_description'];
    bodyAsl = json['body_asl'];
    format = json['format'];
    status = json['status'];
    readStatus = json['read_status'];
    public = json['public'];
    draftVersion = json['draft_version'];
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
    abilities = json['abilities'] != null
        ? new Abilities.fromJson(json['abilities'])
        : null;
    contentUpdatedAt = json['content_updated_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    publishedAt = json['published_at'];
    firstPublishedAt = json['first_published_at'];
    wordCount = json['word_count'];
    content = json['content'];
    selectedAt = json['selected_at'];
    book = json['book'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    lastEditor = json['last_editor'] != null
        ? new User.fromJson(json['last_editor'])
        : null;
    share = json['share'];
    joinToken = json['joinToken'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['space_id'] = this.spaceId;
    data['type'] = this.type;
    data['title'] = this.title;
    data['tag'] = this.tag;
    data['slug'] = this.slug;
    data['user_id'] = this.userId;
    data['book_id'] = this.bookId;
    data['cover'] = this.cover;
    data['description'] = this.description;
    data['custom_description'] = this.customDescription;
    data['body_asl'] = this.bodyAsl;
    data['format'] = this.format;
    data['status'] = this.status;
    data['read_status'] = this.readStatus;
    data['public'] = this.public;
    data['draft_version'] = this.draftVersion;
    data['comments_count'] = this.commentsCount;
    data['likes_count'] = this.likesCount;
    if (this.abilities != null) {
      data['abilities'] = this.abilities.toJson();
    }
    data['content_updated_at'] = this.contentUpdatedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['published_at'] = this.publishedAt;
    data['first_published_at'] = this.firstPublishedAt;
    data['word_count'] = this.wordCount;
    data['content'] = this.content;
    data['selected_at'] = this.selectedAt;
    data['book'] = this.book;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.lastEditor != null) {
      data['last_editor'] = this.lastEditor.toJson();
    }
    data['share'] = this.share;
    data['joinToken'] = this.joinToken;
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
  String largeAvatarUrl;
  String mediumAvatarUrl;
  String smallAvatarUrl;
  int followersCount;
  int followingCount;
  int role;
  int status;
  int public;
  dynamic scene;
  String createdAt;
  String updatedAt;
  bool isPaid;
  dynamic profile;
  String sSerializer;

  User(
      {this.id,
      this.type,
      this.login,
      this.name,
      this.description,
      this.avatar,
      this.avatarUrl,
      this.largeAvatarUrl,
      this.mediumAvatarUrl,
      this.smallAvatarUrl,
      this.followersCount,
      this.followingCount,
      this.role,
      this.status,
      this.public,
      this.scene,
      this.createdAt,
      this.updatedAt,
      this.isPaid,
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
    largeAvatarUrl = json['large_avatar_url'];
    mediumAvatarUrl = json['medium_avatar_url'];
    smallAvatarUrl = json['small_avatar_url'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    role = json['role'];
    status = json['status'];
    public = json['public'];
    scene = json['scene'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isPaid = json['isPaid'];
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
    data['large_avatar_url'] = this.largeAvatarUrl;
    data['medium_avatar_url'] = this.mediumAvatarUrl;
    data['small_avatar_url'] = this.smallAvatarUrl;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['role'] = this.role;
    data['status'] = this.status;
    data['public'] = this.public;
    data['scene'] = this.scene;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['isPaid'] = this.isPaid;
    data['profile'] = this.profile;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
