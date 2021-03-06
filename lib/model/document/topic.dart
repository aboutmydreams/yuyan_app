import 'package:yuyan_app/model/document/group.dart';
import 'package:yuyan_app/model/document/meta/meta.dart';

class TopicSeri {
  String bodyAsl;
  MetaSeri meta;
  int id;
  int spaceId;
  int iid;
  String title;
  dynamic cover;
  dynamic description;
  dynamic body;
  String format;
  int userId;
  int groupId;
  dynamic milestoneId;
  int assigneeId;
  int public;
  int commentsCount;
  int labelsCount;
  dynamic deletedAt;
  dynamic pinnedAt;
  dynamic closedAt;
  String createdAt;
  String updatedAt;
  GroupSeri group;

  TopicSeri({
    this.bodyAsl,
    this.meta,
    this.id,
    this.spaceId,
    this.iid,
    this.title,
    this.cover,
    this.description,
    this.body,
    this.format,
    this.userId,
    this.groupId,
    this.milestoneId,
    this.assigneeId,
    this.public,
    this.commentsCount,
    this.labelsCount,
    this.deletedAt,
    this.pinnedAt,
    this.closedAt,
    this.createdAt,
    this.updatedAt,
    this.group,
  });

  TopicSeri.fromJson(dynamic json) {
    bodyAsl = json["body_asl"];
    meta = json["meta"] != null ? MetaSeri.fromJson(json["meta"]) : null;
    id = json["id"];
    spaceId = json["space_id"];
    iid = json["iid"];
    title = json["title"];
    cover = json["cover"];
    description = json["description"];
    body = json["body"];
    format = json["format"];
    userId = json["user_id"];
    groupId = json["group_id"];
    milestoneId = json["milestone_id"];
    assigneeId = json["assignee_id"];
    public = json["public"];
    commentsCount = json["comments_count"];
    labelsCount = json["labels_count"];
    deletedAt = json["deleted_at"];
    pinnedAt = json["pinned_at"];
    closedAt = json["closed_at"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    group = json["group"] != null ? GroupSeri.fromJson(json["group"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["body_asl"] = bodyAsl;
    if (meta != null) {
      map["meta"] = meta.toJson();
    }
    map["id"] = id;
    map["space_id"] = spaceId;
    map["iid"] = iid;
    map["title"] = title;
    map["cover"] = cover;
    map["description"] = description;
    map["body"] = body;
    map["format"] = format;
    map["user_id"] = userId;
    map["group_id"] = groupId;
    map["milestone_id"] = milestoneId;
    map["assignee_id"] = assigneeId;
    map["public"] = public;
    map["comments_count"] = commentsCount;
    map["labels_count"] = labelsCount;
    map["deleted_at"] = deletedAt;
    map["pinned_at"] = pinnedAt;
    map["closed_at"] = closedAt;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    if (group != null) {
      map["group"] = group.toJson();
    }
    return map;
  }
}
