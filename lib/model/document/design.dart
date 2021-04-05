class DesignSeri {
  int id;
  int spaceId;
  int artboardGroupId;
  int bookId;
  dynamic assetId;
  dynamic assetVersionId;
  int userId;
  String md5;
  String uuid;
  int sort;
  String image;
  dynamic smallImage;
  dynamic labelMapUrl;
  String name;
  int width;
  int height;
  int commentsCount;
  int likesCount;
  String createdAt;
  String updatedAt;
  dynamic contentUpdatedAt;
  int readStatus;
  dynamic deletedAt;

  DesignSeri(
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
      this.readStatus,
      this.deletedAt});

  DesignSeri.fromJson(dynamic json) {
    id = json["id"];
    spaceId = json["space_id"];
    artboardGroupId = json["artboard_group_id"];
    bookId = json["book_id"];
    assetId = json["asset_id"];
    assetVersionId = json["asset_version_id"];
    userId = json["user_id"];
    md5 = json["md5"];
    uuid = json["uuid"];
    sort = json["sort"];
    image = json["image"];
    smallImage = json["small_image"];
    labelMapUrl = json["label_map_url"];
    name = json["name"];
    width = json["width"];
    height = json["height"];
    commentsCount = json["comments_count"];
    likesCount = json["likes_count"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    contentUpdatedAt = json["content_updated_at"];
    readStatus = json["read_status"];
    deletedAt = json["deleted_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["space_id"] = spaceId;
    map["artboard_group_id"] = artboardGroupId;
    map["book_id"] = bookId;
    map["asset_id"] = assetId;
    map["asset_version_id"] = assetVersionId;
    map["user_id"] = userId;
    map["md5"] = md5;
    map["uuid"] = uuid;
    map["sort"] = sort;
    map["image"] = image;
    map["small_image"] = smallImage;
    map["label_map_url"] = labelMapUrl;
    map["name"] = name;
    map["width"] = width;
    map["height"] = height;
    map["comments_count"] = commentsCount;
    map["likes_count"] = likesCount;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["content_updated_at"] = contentUpdatedAt;
    map["read_status"] = readStatus;
    map["deleted_at"] = deletedAt;
    return map;
  }
}
