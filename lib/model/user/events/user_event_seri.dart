import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/user/user.dart';
import 'package:yuyan_app/model/serializer/serializer.dart';

class UserEventSeri {
  int id;
  String createdAt;
  int userId;
  int actorId;
  String targetType;
  int bookId;
  String type;
  int targetCount;
  String updatedAt;
  UserSeri actor;
  dynamic user;
  BookSeri book;
  List<Serializer> targets;
  String serializer;

  UserEventSeri({
    this.id,
    this.createdAt,
    this.userId,
    this.actorId,
    this.targetType,
    this.bookId,
    this.type,
    this.targetCount,
    this.updatedAt,
    this.actor,
    this.user,
    this.book,
    this.targets,
    this.serializer,
  });

  UserEventSeri.fromJson(dynamic json) {
    id = json["id"];
    createdAt = json["created_at"];
    userId = json["user_id"];
    actorId = json["actor_id"];
    targetType = json["target_type"];
    bookId = json["book_id"];
    type = json["type"];
    targetCount = json["target_count"];
    updatedAt = json["updated_at"];
    if (json["actor"] != null) {
      actor = UserSeri.fromJson(json["actor"]);
    }
    user = json["user"];
    if (json["book"] != null) {
      book = BookSeri.fromJson(json["book"]);
    }
    if (json["targets"] != null) {
      targets = [];
      json["targets"].forEach((v) {
        targets.add(Serializer.fromJson(v));
      });
    }
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["created_at"] = createdAt;
    map["user_id"] = userId;
    map["actor_id"] = actorId;
    map["target_type"] = targetType;
    map["book_id"] = bookId;
    map["type"] = type;
    map["target_count"] = targetCount;
    map["updated_at"] = updatedAt;
    if (actor != null) {
      map["actor"] = actor.toJson();
    }
    map["user"] = user;
    if (book != null) {
      map["book"] = book.toJson();
    }
    if (targets != null) {
      map["targets"] = targets.map((v) => v.toJson()).toList();
    }
    map["_serializer"] = serializer;
    return map;
  }
}
