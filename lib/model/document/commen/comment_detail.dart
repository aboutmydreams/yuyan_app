import '../user.dart';

class CommentDetailSeri {
  int id;
  int userId;
  UserSeri user;
  dynamic parentId;
  String format;
  String body;
  String bodyAsl;
  int likesCount;
  int mood;
  String createdAt;
  String updatedAt;
  int status;
  dynamic toUserId;
  dynamic type;
  dynamic selectionId;
  dynamic selectionType;
  dynamic sourceType;
  dynamic sourceId;
  String serializer;

  CommentDetailSeri({
    this.id,
    this.userId,
    this.user,
    this.parentId,
    this.format,
    this.body,
    this.bodyAsl,
    this.likesCount,
    this.mood,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.toUserId,
    this.type,
    this.selectionId,
    this.selectionType,
    this.sourceType,
    this.sourceId,
    this.serializer,
  });

  CommentDetailSeri.fromJson(dynamic json) {
    id = json["id"];
    userId = json["user_id"];
    user = json["user"] != null ? UserSeri.fromJson(json["user"]) : null;
    parentId = json["parent_id"];
    format = json["format"];
    body = json["body"];
    bodyAsl = json["body_asl"];
    likesCount = json["likes_count"];
    mood = json["mood"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    status = json["status"];
    toUserId = json["to_user_id"];
    type = json["type"];
    selectionId = json["selection_id"];
    selectionType = json["selection_type"];
    sourceType = json["source_type"];
    sourceId = json["source_id"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["user_id"] = userId;
    if (user != null) {
      map["user"] = user.toJson();
    }
    map["parent_id"] = parentId;
    map["format"] = format;
    map["body"] = body;
    map["body_asl"] = bodyAsl;
    map["likes_count"] = likesCount;
    map["mood"] = mood;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["status"] = status;
    map["to_user_id"] = toUserId;
    map["type"] = type;
    map["selection_id"] = selectionId;
    map["selection_type"] = selectionType;
    map["source_type"] = sourceType;
    map["source_id"] = sourceId;
    map["_serializer"] = serializer;
    return map;
  }
}
