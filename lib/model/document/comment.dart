import 'meta/meta.dart';

class CommentSeri {
  String body;
  String bodyAsl;
  MetaSeri meta;
  bool isBanned;
  int id;
  int spaceId;
  String commentableType;
  int commentableId;
  int userId;
  int parentId;
  int likesCount;
  String format;
  String createdAt;
  String updatedAt;
  int status;
  dynamic sourceType;
  dynamic sourceId;
  int mood;
  dynamic toUserId;
  dynamic type;
  dynamic selectionId;
  dynamic selectionType;
  dynamic bookId;
  dynamic deletedAt;
  String bodyHtml;
  String fullBodyHtml;

  CommentSeri({
    this.body,
    this.bodyAsl,
    this.meta,
    this.isBanned,
    this.id,
    this.spaceId,
    this.commentableType,
    this.commentableId,
    this.userId,
    this.parentId,
    this.likesCount,
    this.format,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.sourceType,
    this.sourceId,
    this.mood,
    this.toUserId,
    this.type,
    this.selectionId,
    this.selectionType,
    this.bookId,
    this.deletedAt,
    this.bodyHtml,
    this.fullBodyHtml,
  });

  CommentSeri.fromJson(dynamic json) {
    body = json["body"];
    bodyAsl = json["body_asl"];
    meta = json["meta"] != null ? MetaSeri.fromJson(json["meta"]) : null;
    isBanned = json["isBanned"];
    id = json["id"];
    spaceId = json["space_id"];
    commentableType = json["commentable_type"];
    commentableId = json["commentable_id"];
    userId = json["user_id"];
    parentId = json["parent_id"];
    likesCount = json["likes_count"];
    format = json["format"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    status = json["status"];
    sourceType = json["source_type"];
    sourceId = json["source_id"];
    mood = json["mood"];
    toUserId = json["to_user_id"];
    type = json["type"];
    selectionId = json["selection_id"];
    selectionType = json["selection_type"];
    bookId = json["book_id"];
    deletedAt = json["deleted_at"];
    bodyHtml = json["body_html"];
    fullBodyHtml = json["full_body_html"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["body"] = body;
    map["body_asl"] = bodyAsl;
    if (meta != null) {
      map["meta"] = meta.toJson();
    }
    map["isBanned"] = isBanned;
    map["id"] = id;
    map["space_id"] = spaceId;
    map["commentable_type"] = commentableType;
    map["commentable_id"] = commentableId;
    map["user_id"] = userId;
    map["parent_id"] = parentId;
    map["likes_count"] = likesCount;
    map["format"] = format;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["status"] = status;
    map["source_type"] = sourceType;
    map["source_id"] = sourceId;
    map["mood"] = mood;
    map["to_user_id"] = toUserId;
    map["type"] = type;
    map["selection_id"] = selectionId;
    map["selection_type"] = selectionType;
    map["book_id"] = bookId;
    map["deleted_at"] = deletedAt;
    map["body_html"] = bodyHtml;
    map["full_body_html"] = fullBodyHtml;
    return map;
  }
}
