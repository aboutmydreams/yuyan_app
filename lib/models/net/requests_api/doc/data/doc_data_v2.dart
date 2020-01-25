class DocV2 {
  Abilities abilities;
  DocDataV2 data;

  DocV2({this.abilities, this.data});

  DocV2.fromJson(Map<String, dynamic> json) {
    abilities = json['abilities'] != null
        ? new Abilities.fromJson(json['abilities'])
        : null;
    data = json['data'] != null ? new DocDataV2.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.abilities != null) {
      data['abilities'] = this.abilities.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Abilities {
  bool update;
  bool destroy;

  Abilities({this.update, this.destroy});

  Abilities.fromJson(Map<String, dynamic> json) {
    update = json['update'];
    destroy = json['destroy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['update'] = this.update;
    data['destroy'] = this.destroy;
    return data;
  }
}

class DocDataV2 {
  int id;
  String slug;
  String title;
  int bookId;
  Book book;
  int userId;
  User creator;
  String format;
  String body;
  String bodyDraft;
  String bodyHtml;
  String bodyLake;
  int public;
  dynamic status;
  int likesCount;
  int commentsCount;
  String contentUpdatedAt;
  dynamic deletedAt;
  String createdAt;
  String updatedAt;
  String publishedAt;
  dynamic firstPublishedAt;
  int wordCount;
  dynamic cover;
  String description;
  dynamic customDescription;
  String sSerializer;

  DocDataV2(
      {this.id,
      this.slug,
      this.title,
      this.bookId,
      this.book,
      this.userId,
      this.creator,
      this.format,
      this.body,
      this.bodyDraft,
      this.bodyHtml,
      this.bodyLake,
      this.public,
      this.status,
      this.likesCount,
      this.commentsCount,
      this.contentUpdatedAt,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.firstPublishedAt,
      this.wordCount,
      this.cover,
      this.description,
      this.customDescription,
      this.sSerializer});

  DocDataV2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    bookId = json['book_id'];
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
    userId = json['user_id'];
    creator =
        json['creator'] != null ? new User.fromJson(json['creator']) : null;
    format = json['format'];
    body = json['body'];
    bodyDraft = json['body_draft'];
    bodyHtml = json['body_html'];
    bodyLake = json['body_lake'];
    public = json['public'];
    status = json['status'];
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
    contentUpdatedAt = json['content_updated_at'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    publishedAt = json['published_at'];
    firstPublishedAt = json['first_published_at'];
    wordCount = json['word_count'];
    cover = json['cover'];
    description = json['description'];
    customDescription = json['custom_description'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['book_id'] = this.bookId;
    if (this.book != null) {
      data['book'] = this.book.toJson();
    }
    data['user_id'] = this.userId;
    if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
    data['format'] = this.format;
    data['body'] = this.body;
    data['body_draft'] = this.bodyDraft;
    data['body_html'] = this.bodyHtml;
    data['body_lake'] = this.bodyLake;
    data['public'] = this.public;
    data['status'] = this.status;
    data['likes_count'] = this.likesCount;
    data['comments_count'] = this.commentsCount;
    data['content_updated_at'] = this.contentUpdatedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['published_at'] = this.publishedAt;
    data['first_published_at'] = this.firstPublishedAt;
    data['word_count'] = this.wordCount;
    data['cover'] = this.cover;
    data['description'] = this.description;
    data['custom_description'] = this.customDescription;
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
  int creatorId;
  int public;
  int itemsCount;
  int likesCount;
  int watchesCount;
  String contentUpdatedAt;
  String updatedAt;
  String createdAt;
  String namespace;
  User user;
  String sSerializer;

  Book(
      {this.id,
      this.type,
      this.slug,
      this.name,
      this.userId,
      this.description,
      this.creatorId,
      this.public,
      this.itemsCount,
      this.likesCount,
      this.watchesCount,
      this.contentUpdatedAt,
      this.updatedAt,
      this.createdAt,
      this.namespace,
      this.user,
      this.sSerializer});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    slug = json['slug'];
    name = json['name'];
    userId = json['user_id'];
    description = json['description'];
    creatorId = json['creator_id'];
    public = json['public'];
    itemsCount = json['items_count'];
    likesCount = json['likes_count'];
    watchesCount = json['watches_count'];
    contentUpdatedAt = json['content_updated_at'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    namespace = json['namespace'];
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
    data['creator_id'] = this.creatorId;
    data['public'] = this.public;
    data['items_count'] = this.itemsCount;
    data['likes_count'] = this.likesCount;
    data['watches_count'] = this.watchesCount;
    data['content_updated_at'] = this.contentUpdatedAt;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['namespace'] = this.namespace;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
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
  String largeAvatarUrl;
  String mediumAvatarUrl;
  String smallAvatarUrl;
  int booksCount;
  int publicBooksCount;
  int followersCount;
  int followingCount;
  String createdAt;
  String updatedAt;
  String sSerializer;

  User(
      {this.id,
      this.type,
      this.login,
      this.name,
      this.description,
      this.avatarUrl,
      this.largeAvatarUrl,
      this.mediumAvatarUrl,
      this.smallAvatarUrl,
      this.booksCount,
      this.publicBooksCount,
      this.followersCount,
      this.followingCount,
      this.createdAt,
      this.updatedAt,
      this.sSerializer});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    login = json['login'];
    name = json['name'];
    description = json['description'];
    avatarUrl = json['avatar_url'];
    largeAvatarUrl = json['large_avatar_url'];
    mediumAvatarUrl = json['medium_avatar_url'];
    smallAvatarUrl = json['small_avatar_url'];
    booksCount = json['books_count'];
    publicBooksCount = json['public_books_count'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['large_avatar_url'] = this.largeAvatarUrl;
    data['medium_avatar_url'] = this.mediumAvatarUrl;
    data['small_avatar_url'] = this.smallAvatarUrl;
    data['books_count'] = this.booksCount;
    data['public_books_count'] = this.publicBooksCount;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
