import 'package:yuyan_app/model/document/group.dart';
import 'package:yuyan_app/model/document/user.dart';

import 'assignee.dart';
import 'labels.dart';

class TopicSeri {
  int id;
  int spaceId;
  int iid;
  String title;
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
  UserSeri user;
  GroupSeri group;
  AssigneeSeri assignee;
  dynamic milestone;
  List<LabelSeri> labels;
  String serializer;

  TopicSeri({
    this.id,
    this.spaceId,
    this.iid,
    this.title,
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
    this.user,
    this.group,
    this.assignee,
    this.milestone,
    this.labels,
    this.serializer,
  });

  TopicSeri.fromJson(dynamic json) {
    id = json["id"];
    spaceId = json["space_id"];
    iid = json["iid"];
    title = json["title"];
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

    user = json["user"] != null ? UserSeri.fromJson(json["user"]) : null;
    group = json["group"] != null ? GroupSeri.fromJson(json["group"]) : null;
    assignee = json["assignee"] != null
        ? AssigneeSeri.fromJson(json["assignee"])
        : null;
    milestone = json["milestone"];
    if (json["labels"] != null) {
      labels = [];
      json["labels"].forEach((v) {
        labels.add(LabelSeri.fromJson(v));
      });
    }
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["space_id"] = spaceId;
    map["iid"] = iid;
    map["title"] = title;
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
    if (user != null) {
      map["user"] = user.toJson();
    }
    if (group != null) {
      map["group"] = group.toJson();
    }
    if (assignee != null) {
      map["assignee"] = assignee.toJson();
    }
    map["milestone"] = milestone;
    if (labels != null) {
      map["labels"] = labels.map((v) => v.toJson()).toList();
    }
    map["_serializer"] = serializer;
    return map;
  }
}
