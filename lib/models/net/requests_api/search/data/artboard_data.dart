class SearchArtboardJson {
  SearchArtboardData data;

  SearchArtboardJson({this.data});

  SearchArtboardJson.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new SearchArtboardData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class SearchArtboardData {
  String type;
  List<Hits> hits;
  int totalHits;
  int numHits;

  SearchArtboardData({this.type, this.hits, this.totalHits, this.numHits});

  SearchArtboardData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['hits'] != null) {
      hits = new List<Hits>();
      json['hits'].forEach((v) {
        hits.add(new Hits.fromJson(v));
      });
    }
    totalHits = json['totalHits'];
    numHits = json['numHits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.hits != null) {
      data['hits'] = this.hits.map((v) => v.toJson()).toList();
    }
    data['totalHits'] = this.totalHits;
    data['numHits'] = this.numHits;
    return data;
  }
}

class Hits {
  String id;
  String type;
  String abStract;
  String bookName;
  String groupName;
  String name;
  String url;
  Record rRecord;

  Hits(
      {this.id,
      this.type,
      this.abStract,
      this.bookName,
      this.groupName,
      this.name,
      this.url,
      this.rRecord});

  Hits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    abStract = json['abstract'];
    bookName = json['book_name'];
    groupName = json['group_name'];
    name = json['name'];
    url = json['url'];
    rRecord =
        json['_record'] != null ? new Record.fromJson(json['_record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['abstract'] = this.abStract;
    data['book_name'] = this.bookName;
    data['group_name'] = this.groupName;
    data['name'] = this.name;
    data['url'] = this.url;
    if (this.rRecord != null) {
      data['_record'] = this.rRecord.toJson();
    }
    return data;
  }
}

class Record {
  int id;
  int spaceId;
  int artboardGroupId;
  int bookId;
  int assetId;
  int assetVersionId;
  int userId;
  String md5;
  String uuid;
  int sort;
  String image;
  dynamic smallImage;
  String labelMapUrl;
  String name;
  int width;
  int height;
  int commentsCount;
  int likesCount;
  String createdAt;
  String updatedAt;
  dynamic contentUpdatedAt;
  dynamic deletedAt;
  Book book;

  Record(
      {this.id,
      this.spaceId,
      this.artboardGroupId,
      this.bookId,
      this.assetId,
      this.assetVersionId,
      this.userId,
      this.md5,
      this.uuid,
      this.sort,
      this.image,
      this.smallImage,
      this.labelMapUrl,
      this.name,
      this.width,
      this.height,
      this.commentsCount,
      this.likesCount,
      this.createdAt,
      this.updatedAt,
      this.contentUpdatedAt,
      this.deletedAt,
      this.book});

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    spaceId = json['space_id'];
    artboardGroupId = json['artboard_group_id'];
    bookId = json['book_id'];
    assetId = json['asset_id'];
    assetVersionId = json['asset_version_id'];
    userId = json['user_id'];
    md5 = json['md5'];
    uuid = json['uuid'];
    sort = json['sort'];
    image = json['image'];
    smallImage = json['small_image'];
    labelMapUrl = json['label_map_url'];
    name = json['name'];
    width = json['width'];
    height = json['height'];
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentUpdatedAt = json['content_updated_at'];
    deletedAt = json['deleted_at'];
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['space_id'] = this.spaceId;
    data['artboard_group_id'] = this.artboardGroupId;
    data['book_id'] = this.bookId;
    data['asset_id'] = this.assetId;
    data['asset_version_id'] = this.assetVersionId;
    data['user_id'] = this.userId;
    data['md5'] = this.md5;
    data['uuid'] = this.uuid;
    data['sort'] = this.sort;
    data['image'] = this.image;
    data['small_image'] = this.smallImage;
    data['label_map_url'] = this.labelMapUrl;
    data['name'] = this.name;
    data['width'] = this.width;
    data['height'] = this.height;
    data['comments_count'] = this.commentsCount;
    data['likes_count'] = this.likesCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['content_updated_at'] = this.contentUpdatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.book != null) {
      data['book'] = this.book.toJson();
    }
    return data;
  }
}

class Book {
  String contentUpdatedAt;
  bool enableComment;
  bool enableExport;
  bool enableVisitorWatermark;
  String copyrightWatermark;
  String imageCopyrightWatermark;
  bool enableSearchEngine;
  bool enableWebhook;
  bool enableTrash;
  bool isBanned;
  int id;
  String type;
  String name;
  String slug;
  String description;
  int userId;
  int public;
  String createdAt;
  String updatedAt;
  User user;

  Book(
      {this.contentUpdatedAt,
      this.enableComment,
      this.enableExport,
      this.enableVisitorWatermark,
      this.copyrightWatermark,
      this.imageCopyrightWatermark,
      this.enableSearchEngine,
      this.enableWebhook,
      this.enableTrash,
      this.isBanned,
      this.id,
      this.type,
      this.name,
      this.slug,
      this.description,
      this.userId,
      this.public,
      this.createdAt,
      this.updatedAt,
      this.user});

  Book.fromJson(Map<String, dynamic> json) {
    contentUpdatedAt = json['content_updated_at'];
    enableComment = json['enable_comment'];
    enableExport = json['enable_export'];
    enableVisitorWatermark = json['enable_visitor_watermark'];
    copyrightWatermark = json['copyright_watermark'];
    imageCopyrightWatermark = json['image_copyright_watermark'];
    enableSearchEngine = json['enable_search_engine'];
    enableWebhook = json['enable_webhook'];
    enableTrash = json['enable_trash'];
    isBanned = json['isBanned'];
    id = json['id'];
    type = json['type'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    userId = json['user_id'];
    public = json['public'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content_updated_at'] = this.contentUpdatedAt;
    data['enable_comment'] = this.enableComment;
    data['enable_export'] = this.enableExport;
    data['enable_visitor_watermark'] = this.enableVisitorWatermark;
    data['copyright_watermark'] = this.copyrightWatermark;
    data['image_copyright_watermark'] = this.imageCopyrightWatermark;
    data['enable_search_engine'] = this.enableSearchEngine;
    data['enable_webhook'] = this.enableWebhook;
    data['enable_trash'] = this.enableTrash;
    data['isBanned'] = this.isBanned;
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['user_id'] = this.userId;
    data['public'] = this.public;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  String workId;
  String avatarUrl;
  String smallAvatarUrl;
  String mediumAvatarUrl;
  String largeAvatarUrl;
  bool isActive;
  bool isDeactived;
  bool isBanned;
  bool isExtcontact;
  bool isPaid;
  bool hasPaidBefore;
  int id;
  String type;
  String login;
  String name;
  String description;
  String avatar;
  int public;
  int followersCount;
  int followingCount;
  String scene;
  String createdAt;
  String updatedAt;
  int organizationId;
  int memberLevel;
  dynamic expiredAt;
  int status;

  User(
      {this.workId,
      this.avatarUrl,
      this.smallAvatarUrl,
      this.mediumAvatarUrl,
      this.largeAvatarUrl,
      this.isActive,
      this.isDeactived,
      this.isBanned,
      this.isExtcontact,
      this.isPaid,
      this.hasPaidBefore,
      this.id,
      this.type,
      this.login,
      this.name,
      this.description,
      this.avatar,
      this.public,
      this.followersCount,
      this.followingCount,
      this.scene,
      this.createdAt,
      this.updatedAt,
      this.organizationId,
      this.memberLevel,
      this.expiredAt,
      this.status});

  User.fromJson(Map<String, dynamic> json) {
    workId = json['work_id'];
    avatarUrl = json['avatar_url'];
    smallAvatarUrl = json['small_avatar_url'];
    mediumAvatarUrl = json['medium_avatar_url'];
    largeAvatarUrl = json['large_avatar_url'];
    isActive = json['isActive'];
    isDeactived = json['isDeactived'];
    isBanned = json['isBanned'];
    isExtcontact = json['isExtcontact'];
    isPaid = json['isPaid'];
    hasPaidBefore = json['hasPaidBefore'];
    id = json['id'];
    type = json['type'];
    login = json['login'];
    name = json['name'];
    description = json['description'];
    avatar = json['avatar'];
    public = json['public'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    scene = json['scene'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    organizationId = json['organization_id'];
    memberLevel = json['member_level'];
    expiredAt = json['expired_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['work_id'] = this.workId;
    data['avatar_url'] = this.avatarUrl;
    data['small_avatar_url'] = this.smallAvatarUrl;
    data['medium_avatar_url'] = this.mediumAvatarUrl;
    data['large_avatar_url'] = this.largeAvatarUrl;
    data['isActive'] = this.isActive;
    data['isDeactived'] = this.isDeactived;
    data['isBanned'] = this.isBanned;
    data['isExtcontact'] = this.isExtcontact;
    data['isPaid'] = this.isPaid;
    data['hasPaidBefore'] = this.hasPaidBefore;
    data['id'] = this.id;
    data['type'] = this.type;
    data['login'] = this.login;
    data['name'] = this.name;
    data['description'] = this.description;
    data['avatar'] = this.avatar;
    data['public'] = this.public;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['scene'] = this.scene;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['organization_id'] = this.organizationId;
    data['member_level'] = this.memberLevel;
    data['expired_at'] = this.expiredAt;
    data['status'] = this.status;
    return data;
  }
}
