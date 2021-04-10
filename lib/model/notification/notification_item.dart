import 'package:yuyan_app/model/document/user.dart';
import 'package:yuyan_app/model/serializer/serializer.dart';

class NotificationItemSeri {
  dynamic params;
  int id;
  int spaceId;
  int organizationId;
  String notifyType;
  int userId;
  int actorId;
  String subjectType;
  String secondSubjectType;
  String thirdSubjectType;

  int subjectId;
  int secondSubjectId;
  int thirdSubjectId;

  String readAt;
  String createdAt;
  String updatedAt;

  UserSeri actor;

  Serializer subject;
  Serializer secondSubject;
  Serializer thirdSubject;

  NotificationItemSeri({
    this.params,
    this.id,
    this.spaceId,
    this.organizationId,
    this.notifyType,
    this.userId,
    this.actorId,
    this.subjectType,
    this.subjectId,
    this.secondSubjectType,
    this.secondSubjectId,
    this.thirdSubjectType,
    this.thirdSubjectId,
    this.readAt,
    this.createdAt,
    this.updatedAt,
    this.actor,
    this.subject,
    this.secondSubject,
  });

  NotificationItemSeri.fromJson(dynamic json) {
    params = json["params"];
    id = json["id"];
    spaceId = json["space_id"];
    organizationId = json["organization_id"];
    notifyType = json["notify_type"];
    userId = json["user_id"];
    actorId = json["actor_id"];
    subjectType = json["subject_type"];
    subjectId = json["subject_id"];
    secondSubjectType = json["second_subject_type"];
    secondSubjectId = json["second_subject_id"];
    thirdSubjectType = json["third_subject_type"];
    thirdSubjectId = json["third_subject_id"];
    readAt = json["read_at"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    actor = json["actor"] != null ? UserSeri.fromJson(json["actor"]) : null;

    subject = json["subject"] != null
        ? Serializer(serializer: subjectType, json: json["subject"])
        : null;
    secondSubject = json["second_subject"] != null
        ? Serializer(serializer: secondSubjectType, json: json["second_subject"])
        : null;
    thirdSubject = json["third_subject"] != null
        ? Serializer(serializer: thirdSubjectType, json: json['third_subject'])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["params"] = params;
    map["id"] = id;
    map["space_id"] = spaceId;
    map["organization_id"] = organizationId;
    map["notify_type"] = notifyType;
    map["user_id"] = userId;
    map["actor_id"] = actorId;
    map["subject_type"] = subjectType;
    map["subject_id"] = subjectId;
    map["second_subject_type"] = secondSubjectType;
    map["second_subject_id"] = secondSubjectId;
    map["third_subject_type"] = thirdSubjectType;
    map["third_subject_id"] = thirdSubjectId;
    map["read_at"] = readAt;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    if (actor != null) {
      map["actor"] = actor.toJson();
    }
    if (subject != null) {
      map["subject"] = subject.toJson();
    }
    if (secondSubject != null) {
      map["second_subject"] = secondSubject.toJson();
    }
    if (thirdSubject != null) {
      map['third_subject'] = thirdSubject.toJson();
    }
    return map;
  }
}
