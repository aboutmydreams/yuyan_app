import 'package:yuyan_app/model/document/book.dart';
import 'package:yuyan_app/model/user/group/group.dart';
import 'package:yuyan_app/model/serializer/serializer.dart';

class ActionResultSeri {
  int count;
  ActionSeri actioned;

  ActionResultSeri.fromJson(json) {
    count = json['count'];
    if (json['actioned'] != null) {
      actioned = ActionSeri.fromJson(json['actioned']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'actioned': actioned?.toJson(),
    };
  }
}

class ActionSeri {
  int id;
  int userId;
  String title;
  String url;
  String createdAt;
  String updatedAt;

  int targetBookId;
  int targetGroupId;
  GroupSeri targetGroup;
  BookSeri targetBook;

  String actionType;
  String actionName;
  int targetId;
  String targetType;
  Serializer target;

  dynamic actionOption;
  String serializer;

  ActionSeri({
    this.id,
    this.userId,
    this.actionType,
    this.actionName,
    this.targetType,
    this.targetId,
    this.actionOption,
    this.title,
    this.targetBookId,
    this.targetGroupId,
    this.createdAt,
    this.updatedAt,
    this.targetGroup,
    this.targetBook,
    this.url,
    this.serializer,
  });

  ActionSeri.fromJson(dynamic json) {
    if (json == null) return;
    id = json["id"];
    userId = json["user_id"];
    actionType = json["action_type"];
    actionName = json["action_name"];
    targetType = json["target_type"];
    targetId = json["target_id"];
    actionOption = json["action_option"];
    title = json["title"];
    targetBookId = json["target_book_id"];
    targetGroupId = json["target_group_id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];

    target = Serializer.fromJson(json['target']);

    if (json['target_group'] != null) {
      targetGroup = GroupSeri.fromJson(json["target_group"]);
    }
    if (json['target_book'] != null) {
      targetBook = BookSeri.fromJson(json["target_book"]);
    }

    url = json["_url"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["user_id"] = userId;
    map["action_type"] = actionType;
    map["action_name"] = actionName;
    map["target_type"] = targetType;
    map["target_id"] = targetId;
    map["action_option"] = actionOption;
    map["title"] = title;
    map["target_book_id"] = targetBookId;
    map["target_group_id"] = targetGroupId;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map['target'] = target?.toJson();
    if (targetGroup != null) {
      map["target_group"] = targetGroup.toJson();
    }
    if (targetBook != null) {
      map["target_book"] = targetBook.toJson();
    }
    map["_url"] = url;
    map["_serializer"] = serializer;
    return map;
  }
}
