class UserBookJson {
  List<UserBookData> data;

  UserBookJson({this.data});

  UserBookJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<UserBookData>();
      json['data'].forEach((v) {
        data.add(new UserBookData.fromJson(v));
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

class UserBookData {
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

  UserBookData(
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

  UserBookData.fromJson(Map<String, dynamic> json) {
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
