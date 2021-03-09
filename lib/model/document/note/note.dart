import 'package:yuyan_app/model/document/note/doclet.dart';

class NoteSeri {
  int id;
  int docletId;
  int userId;
  String description;
  String contentUpdatedAt;
  String firstPublishedAt;
  String updatedAt;
  String createdAt;
  dynamic saveFrom;
  int public;
  dynamic slug;
  int commentsCount;
  int likesCount;
  bool hasImage;
  bool hasTodo;
  bool hasBookmark;
  bool hasAttachment;
  bool isPublic;
  String serializer;

  DocletSeri doclet;

  NoteSeri({
    this.id,
    this.docletId,
    this.userId,
    this.description,
    this.contentUpdatedAt,
    this.firstPublishedAt,
    this.updatedAt,
    this.createdAt,
    this.saveFrom,
    this.public,
    this.slug,
    this.commentsCount,
    this.likesCount,
    this.hasImage,
    this.hasTodo,
    this.hasBookmark,
    this.hasAttachment,
    this.isPublic,
    this.serializer,
    this.doclet,
  });

  NoteSeri.fromJson(dynamic json) {
    id = json["id"];
    docletId = json["doclet_id"];
    userId = json["user_id"];
    description = json["description"];
    contentUpdatedAt = json["content_updated_at"];
    firstPublishedAt = json["first_published_at"];
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
    saveFrom = json["save_from"];
    public = json["public"];
    slug = json["slug"];
    commentsCount = json["comments_count"];
    likesCount = json["likes_count"];
    hasImage = json["has_image"];
    hasTodo = json["has_todo"];
    hasBookmark = json["has_bookmark"];
    hasAttachment = json["has_attachment"];
    isPublic = json["is_public"];
    serializer = json["_serializer"];

    if (json['doclet'] != null) {
      doclet = DocletSeri.fromJson(json['doclet']);
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["doclet_id"] = docletId;
    map["user_id"] = userId;
    map["description"] = description;
    map["content_updated_at"] = contentUpdatedAt;
    map["first_published_at"] = firstPublishedAt;
    map["updated_at"] = updatedAt;
    map["created_at"] = createdAt;
    map["save_from"] = saveFrom;
    map["public"] = public;
    map["slug"] = slug;
    map["comments_count"] = commentsCount;
    map["likes_count"] = likesCount;
    map["has_image"] = hasImage;
    map["has_todo"] = hasTodo;
    map["has_bookmark"] = hasBookmark;
    map["has_attachment"] = hasAttachment;
    map["is_public"] = isPublic;
    map["_serializer"] = serializer;
    if (doclet != null) {
      map['doclet'] = doclet.toJson();
    }
    return map;
  }
}
