import 'package:yuyan_app/model/serializer/serializer.dart';

import 'book_event_seri.dart';
import 'user_lite_seri.dart';

class EventSeri {
  int id;
  int spaceId;
  int userId;
  int organizationId;
  String eventType;
  String subjectType;
  int subjectId;
  String secondSubjectType;
  int secondSubjectId;
  String thirdSubjectType;
  int thirdSubjectId;
  int actorId;
  int bookId;
  Map params;
  String createdAt;
  String updatedAt;
  Serializer subject;
  List<Serializer> subjects;
  Serializer secondSubject;
  Serializer thirdSubject;
  UserLiteSeri actor;
  BookEventSeri book;
  String sSerializer;

  EventSeri({
    this.id,
    this.spaceId,
    this.userId,
    this.organizationId,
    this.eventType,
    this.subjectType,
    this.subjectId,
    this.secondSubjectType,
    this.secondSubjectId,
    this.thirdSubjectType,
    this.thirdSubjectId,
    this.actorId,
    this.bookId,
    this.params,
    this.createdAt,
    this.updatedAt,
    this.subject,
    this.secondSubject,
    this.thirdSubject,
    this.actor,
    this.book,
    this.sSerializer,
  });

  EventSeri.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    spaceId = json['space_id'];
    userId = json['user_id'];
    organizationId = json['organization_id'];
    eventType = json['event_type'];
    subjectType = json['subject_type'];
    subjectId = json['subject_id'];
    secondSubjectType = json['second_subject_type'];
    secondSubjectId = json['second_subject_id'];
    thirdSubjectType = json['third_subject_type'];
    thirdSubjectId = json['third_subject_id'];
    actorId = json['actor_id'];
    bookId = json['book_id'];
    params = json['params'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subject = Serializer.fromJson(json['subject']);
    if (json['subjects'] != null) {
      subjects = (json['subjects'] as List)
          .map((e) => Serializer.fromJson(e))
          .toList();
    }
    secondSubject = Serializer.fromJson(json['second_subject']);
    thirdSubject = Serializer.fromJson(json['third_subject']);
    actor = UserLiteSeri.fromJson(json['actor']);
    book = BookEventSeri.fromJson(json['book']);
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['space_id'] = this.spaceId;
    data['user_id'] = this.userId;
    data['organization_id'] = this.organizationId;
    data['event_type'] = this.eventType;
    data['subject_type'] = this.subjectType;
    data['subject_id'] = this.subjectId;
    data['second_subject_type'] = this.secondSubjectType;
    data['second_subject_id'] = this.secondSubjectId;
    data['third_subject_type'] = this.thirdSubjectType;
    data['third_subject_id'] = this.thirdSubjectId;
    data['actor_id'] = this.actorId;
    data['book_id'] = this.bookId;
    data['params'] = this.params;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['subject'] = this.subject?.toJson();
    data['subjects'] =
        subjects == null ? null : subjects.map((e) => e.toJson()).toList();
    data['second_subject'] = this.secondSubject?.toJson();
    data['third_subject'] = this.thirdSubject?.toJson();
    data['actor'] = this.actor?.toJson();
    data['book'] = this.book?.toJson();
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
