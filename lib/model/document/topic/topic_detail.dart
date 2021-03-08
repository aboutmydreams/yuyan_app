import 'collab.dart';
import 'user.dart';
import 'labels.dart';

class TopicDetail {
  int id;
  int iid;
  String title;
  int userId;
  dynamic assigneeId;
  int groupId;
  dynamic milestoneId;
  dynamic milestone;
  String format;
  dynamic body;
  String bodyAsl;
  String bodyHtml;
  int commentsCount;
  int labelsCount;
  int public;
  Collab collab;
  dynamic pinnedAt;
  dynamic deletedAt;
  dynamic closedAt;
  String createdAt;
  String updatedAt;
  User user;
  dynamic assignee;
  dynamic group;
  List<Labels> labels;
  String serializer;

  TopicDetail({
      this.id, 
      this.iid, 
      this.title, 
      this.userId, 
      this.assigneeId, 
      this.groupId, 
      this.milestoneId, 
      this.milestone, 
      this.format, 
      this.body, 
      this.bodyAsl, 
      this.bodyHtml, 
      this.commentsCount, 
      this.labelsCount, 
      this.public, 
      this.collab, 
      this.pinnedAt, 
      this.deletedAt, 
      this.closedAt, 
      this.createdAt, 
      this.updatedAt, 
      this.user, 
      this.assignee, 
      this.group, 
      this.labels, 
      this.serializer});

  TopicDetail.fromJson(dynamic json) {
    id = json["id"];
    iid = json["iid"];
    title = json["title"];
    userId = json["user_id"];
    assigneeId = json["assignee_id"];
    groupId = json["group_id"];
    milestoneId = json["milestone_id"];
    milestone = json["milestone"];
    format = json["format"];
    body = json["body"];
    bodyAsl = json["body_asl"];
    bodyHtml = json["body_html"];
    commentsCount = json["comments_count"];
    labelsCount = json["labels_count"];
    public = json["public"];
    collab = json["collab"] != null ? Collab.fromJson(json["collab"]) : null;
    pinnedAt = json["pinned_at"];
    deletedAt = json["deleted_at"];
    closedAt = json["closed_at"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    user = json["user"] != null ? User.fromJson(json["user"]) : null;
    assignee = json["assignee"];
    group = json["group"];
    if (json["labels"] != null) {
      labels = [];
      json["labels"].forEach((v) {
        labels.add(Labels.fromJson(v));
      });
    }
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["iid"] = iid;
    map["title"] = title;
    map["user_id"] = userId;
    map["assignee_id"] = assigneeId;
    map["group_id"] = groupId;
    map["milestone_id"] = milestoneId;
    map["milestone"] = milestone;
    map["format"] = format;
    map["body"] = body;
    map["body_asl"] = bodyAsl;
    map["body_html"] = bodyHtml;
    map["comments_count"] = commentsCount;
    map["labels_count"] = labelsCount;
    map["public"] = public;
    if (collab != null) {
      map["collab"] = collab.toJson();
    }
    map["pinned_at"] = pinnedAt;
    map["deleted_at"] = deletedAt;
    map["closed_at"] = closedAt;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    if (user != null) {
      map["user"] = user.toJson();
    }
    map["assignee"] = assignee;
    map["group"] = group;
    if (labels != null) {
      map["labels"] = labels.map((v) => v.toJson()).toList();
    }
    map["_serializer"] = serializer;
    return map;
  }

}