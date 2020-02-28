class UserInfoJson {
  TheInfo data;

  UserInfoJson({this.data});

  UserInfoJson.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new TheInfo.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class TheInfo {
  int id;
  String type;
  int spaceId;
  int accountId;
  String login;
  String name;
  String avatarUrl;
  String largeAvatarUrl;
  String mediumAvatarUrl;
  String smallAvatarUrl;
  int booksCount;
  int publicBooksCount;
  int followersCount;
  int followingCount;
  int public;
  String description;
  String createdAt;
  String updatedAt;
  String sSerializer;

  TheInfo(
      {this.id,
      this.type,
      this.spaceId,
      this.accountId,
      this.login,
      this.name,
      this.avatarUrl,
      this.largeAvatarUrl,
      this.mediumAvatarUrl,
      this.smallAvatarUrl,
      this.booksCount,
      this.publicBooksCount,
      this.followersCount,
      this.followingCount,
      this.public,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.sSerializer});

  TheInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    spaceId = json['space_id'];
    accountId = json['account_id'];
    login = json['login'];
    name = json['name'];
    avatarUrl = json['avatar_url'];
    largeAvatarUrl = json['large_avatar_url'];
    mediumAvatarUrl = json['medium_avatar_url'];
    smallAvatarUrl = json['small_avatar_url'];
    booksCount = json['books_count'];
    publicBooksCount = json['public_books_count'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    public = json['public'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['space_id'] = this.spaceId;
    data['account_id'] = this.accountId;
    data['login'] = this.login;
    data['name'] = this.name;
    data['avatar_url'] = this.avatarUrl;
    data['large_avatar_url'] = this.largeAvatarUrl;
    data['medium_avatar_url'] = this.mediumAvatarUrl;
    data['small_avatar_url'] = this.smallAvatarUrl;
    data['books_count'] = this.booksCount;
    data['public_books_count'] = this.publicBooksCount;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['public'] = this.public;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
