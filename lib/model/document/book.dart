import 'user.dart';

class BookSeri {
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
  String layout;
  String docViewport;
  dynamic docTypography;
  bool enableAutoPublish;
  UserSeri user;
  dynamic creator;
  String serializer;

  BookSeri({
    this.id,
    this.type,
    this.slug,
    this.name,
    this.userId,
    this.description,
    this.public,
    this.createdAt,
    this.updatedAt,
    this.contentUpdatedAt,
    this.layout,
    this.docViewport,
    this.docTypography,
    this.enableAutoPublish,
    this.user,
    this.creator,
    this.serializer,
  });

  BookSeri.fromJson(dynamic json) {
    id = json["id"];
    type = json["type"];
    slug = json["slug"];
    name = json["name"];
    userId = json["user_id"];
    description = json["description"];
    public = json["public"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    contentUpdatedAt = json["content_updated_at"];
    layout = json["layout"];
    docViewport = json["doc_viewport"];
    docTypography = json["doc_typography"];
    enableAutoPublish = json["enable_auto_publish"];
    user = json["user"] != null ? UserSeri.fromJson(json["user"]) : null;
    creator = json["creator"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["type"] = type;
    map["slug"] = slug;
    map["name"] = name;
    map["user_id"] = userId;
    map["description"] = description;
    map["public"] = public;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["content_updated_at"] = contentUpdatedAt;
    map["layout"] = layout;
    map["doc_viewport"] = docViewport;
    map["doc_typography"] = docTypography;
    map["enable_auto_publish"] = enableAutoPublish;
    if (user != null) {
      map["user"] = user.toJson();
    }
    map["creator"] = creator;
    map["_serializer"] = serializer;
    return map;
  }
}
