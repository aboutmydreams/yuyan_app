import 'user.dart';
import 'group.dart';

class GroupUserSeri {
  String joinedAt;
  int epv30;
  int id;
  int spaceId;
  int groupId;
  int userId;
  int role;
  int status;
  dynamic deletedAt;
  dynamic pinnedAt;
  dynamic departmentName;
  dynamic groupDepartmentId;
  String name;
  int creatorId;
  String createdAt;
  String updatedAt;
  UserSeri user;
  GroupSeri group;

  GroupUserSeri({
    this.joinedAt,
    this.id,
    this.epv30,
    this.spaceId,
    this.groupId,
    this.userId,
    this.role,
    this.status,
    this.deletedAt,
    this.pinnedAt,
    this.departmentName,
    this.groupDepartmentId,
    this.name,
    this.creatorId,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.group,
  });

  GroupUserSeri.fromJson(dynamic json) {
    joinedAt = json["joined_at"];
    epv30 = json["epv_30"];
    id = json["id"];
    spaceId = json["space_id"];
    groupId = json["group_id"];
    userId = json["user_id"];
    role = json["role"];
    status = json["status"];
    deletedAt = json["deleted_at"];
    pinnedAt = json["pinned_at"];
    departmentName = json["department_name"];
    groupDepartmentId = json["group_department_id"];
    name = json["name"];
    creatorId = json["creator_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    user = json["user"] != null ? UserSeri.fromJson(json["user"]) : null;
    group = json["group"] != null ? GroupSeri.fromJson(json["group"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["joined_at"] = joinedAt;
    map["id"] = id;
    map["epv_30"] = epv30;
    map["space_id"] = spaceId;
    map["group_id"] = groupId;
    map["user_id"] = userId;
    map["role"] = role;
    map["status"] = status;
    map["deleted_at"] = deletedAt;
    map["pinned_at"] = pinnedAt;
    map["department_name"] = departmentName;
    map["group_department_id"] = groupDepartmentId;
    map["name"] = name;
    map["creator_id"] = creatorId;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    if (user != null) {
      map["user"] = user.toJson();
    }
    if (group != null) {
      map["group"] = group.toJson();
    }
    return map;
  }
}
