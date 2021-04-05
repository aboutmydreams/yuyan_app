import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/model/events/user_lite_seri.dart';
import 'package:yuyan_app/model/serializer/serializer.dart';

class UserRecentSeri {
  int id;
  int organizationId;
  int userId;
  String action;
  String subjectType;
  String targetType;
  int targetId;
  bool canEdit;
  bool isQuickLink;
  String url;
  String createdAt;
  String updatedAt;
  String title;
  Serializer target;
  BookSeri book;
  UserSeri user;
  dynamic share;
  UserLiteSeri creator;
  String serializer;

  UserRecentSeri({
    this.id,
    this.organizationId,
    this.userId,
    this.action,
    this.subjectType,
    this.targetType,
    this.targetId,
    this.canEdit,
    this.isQuickLink,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.target,
    this.book,
    this.user,
    this.share,
    this.creator,
    this.serializer,
  });

  UserRecentSeri.fromJson(dynamic json) {
    id = json["id"];
    organizationId = json["organization_id"];
    userId = json["user_id"];
    action = json["action"];
    subjectType = json["subject_type"];
    targetType = json["target_type"];
    targetId = json["target_id"];
    canEdit = json["canEdit"];
    isQuickLink = json["isQuickLink"];
    url = json["url"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    title = json["title"];
    target =
        json["target"] != null ? Serializer.fromJson(json["target"]) : null;
    book = json["book"] != null ? BookSeri.fromJson(json["book"]) : null;
    user = json["user"] != null ? UserSeri.fromJson(json["user"]) : null;
    share = json["share"];
    creator =
        json["creator"] != null ? UserLiteSeri.fromJson(json["creator"]) : null;
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["organization_id"] = organizationId;
    map["user_id"] = userId;
    map["action"] = action;
    map["subject_type"] = subjectType;
    map["target_type"] = targetType;
    map["target_id"] = targetId;
    map["canEdit"] = canEdit;
    map["isQuickLink"] = isQuickLink;
    map["url"] = url;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["title"] = title;
    if (target != null) {
      map["target"] = target.toJson();
    }
    if (book != null) {
      map["book"] = book.toJson();
    }
    if (user != null) {
      map["user"] = user.toJson();
    }
    map["share"] = share;
    if (creator != null) {
      map["creator"] = creator.toJson();
    }
    map["_serializer"] = serializer;
    return map;
  }
}
