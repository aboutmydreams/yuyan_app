import 'package:yuyan_app/model/user/user.dart';

class ResourceSeri {
  int id;
  int bookId;
  int filesize;
  String filename;
  String ext;
  String type;
  String targetType;
  int targetId;
  int parentId;
  int userId;
  String createdAt;
  String updatedAt;
  String versionCreatedAt;
  String filekey;
  UserSeri user;
  String serializer;

  ResourceSeri({
    this.id,
    this.bookId,
    this.filesize,
    this.filename,
    this.ext,
    this.type,
    this.targetType,
    this.targetId,
    this.parentId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.versionCreatedAt,
    this.filekey,
    this.user,
    this.serializer,
  });

  ResourceSeri.fromJson(json) {
    id = json["id"];
    bookId = json["book_id"];
    filesize = json["filesize"];
    filename = json["filename"];
    ext = json["ext"];
    type = json["type"];
    targetType = json["target_type"];
    targetId = json["target_id"];
    parentId = json["parent_id"];
    userId = json["user_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    versionCreatedAt = json["version_created_at"];
    filekey = json["filekey"];
    if (json["user"] != null) {
      user = UserSeri.fromJson(json["user"]);
    }
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["book_id"] = bookId;
    map["filesize"] = filesize;
    map["filename"] = filename;
    map["ext"] = ext;
    map["type"] = type;
    map["target_type"] = targetType;
    map["target_id"] = targetId;
    map["parent_id"] = parentId;
    map["user_id"] = userId;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["version_created_at"] = versionCreatedAt;
    map["filekey"] = filekey;
    map["user"] = user?.toJson();
    map["_serializer"] = serializer;
    return map;
  }
}
