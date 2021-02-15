class GroupBookJson {
  List<BookData> data;

  GroupBookJson({this.data});

  GroupBookJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BookData>[];
      json['data'].forEach((v) {
        data.add(new BookData.fromJson(v));
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

class BookData {
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
  dynamic pinnedAt;
  String archivedAt;
  int status;
  int stackId;
  int rank;
  User user;
  dynamic creator;
  String sSerializer;

  BookData(
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
      this.status,
      this.stackId,
      this.rank,
      this.user,
      this.creator,
      this.sSerializer});

  BookData.fromJson(Map<String, dynamic> json) {
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
