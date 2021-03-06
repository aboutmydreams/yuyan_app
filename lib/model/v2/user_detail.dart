class UserDetailSeri {
  int id;
  String type;
  int spaceId;
  int accountId;
  String login;
  String name;
  String avatarUrl;
  int booksCount;
  int publicBooksCount;
  int followersCount;
  int followingCount;
  int public;
  String description;
  String createdAt;
  String updatedAt;
  String serializer;

  UserDetailSeri({
    this.id,
    this.type,
    this.spaceId,
    this.accountId,
    this.login,
    this.name,
    this.avatarUrl,
    this.booksCount,
    this.publicBooksCount,
    this.followersCount,
    this.followingCount,
    this.public,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.serializer,
  });

  UserDetailSeri.fromJson(dynamic json) {
    id = json["id"];
    type = json["type"];
    spaceId = json["space_id"];
    accountId = json["account_id"];
    login = json["login"];
    name = json["name"];
    avatarUrl = json["avatar_url"];
    booksCount = json["books_count"];
    publicBooksCount = json["public_books_count"];
    followersCount = json["followers_count"];
    followingCount = json["following_count"];
    public = json["public"];
    description = json["description"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["type"] = type;
    map["space_id"] = spaceId;
    map["account_id"] = accountId;
    map["login"] = login;
    map["name"] = name;
    map["avatar_url"] = avatarUrl;
    map["books_count"] = booksCount;
    map["public_books_count"] = publicBooksCount;
    map["followers_count"] = followersCount;
    map["following_count"] = followingCount;
    map["public"] = public;
    map["description"] = description;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["_serializer"] = serializer;
    return map;
  }
}
