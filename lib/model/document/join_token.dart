import 'package:yuyan_app/model/document/user.dart';

class JoinTokenSeri {
  int id;
  String targetType;
  int targetId;
  String token;
  int approve;
  UserSeri creator;
  String createdAt;
  dynamic expiredAt;
  String updatedAt;
  int role;
  String serializer;

  JoinTokenSeri(
      {this.id,
      this.targetType,
      this.targetId,
      this.token,
      this.approve,
      this.creator,
      this.createdAt,
      this.expiredAt,
      this.updatedAt,
      this.role,
      this.serializer});

  JoinTokenSeri.fromJson(dynamic json) {
    id = json["id"];
    targetType = json["target_type"];
    targetId = json["target_id"];
    token = json["token"];
    approve = json["approve"];
    creator =
        json["creator"] != null ? UserSeri.fromJson(json["creator"]) : null;
    createdAt = json["created_at"];
    expiredAt = json["expired_at"];
    updatedAt = json["updated_at"];
    role = json["role"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["target_type"] = targetType;
    map["target_id"] = targetId;
    map["token"] = token;
    map["approve"] = approve;
    if (creator != null) {
      map["creator"] = creator.toJson();
    }
    map["created_at"] = createdAt;
    map["expired_at"] = expiredAt;
    map["updated_at"] = updatedAt;
    map["role"] = role;
    map["_serializer"] = serializer;
    return map;
  }
}
