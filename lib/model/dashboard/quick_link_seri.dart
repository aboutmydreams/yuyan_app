class QuickLinkSeri {
  int id;
  int userId;
  int organizationId;
  String type;
  dynamic icon;
  String title;
  String url;
  int orderNum;
  int targetId;
  String targetType;
  String createdAt;
  String updatedAt;
  String refId;
  dynamic target;
  dynamic user;
  String serializer;

  QuickLinkSeri({
    this.id,
    this.userId,
    this.organizationId,
    this.type,
    this.icon,
    this.title,
    this.url,
    this.orderNum,
    this.targetId,
    this.targetType,
    this.createdAt,
    this.updatedAt,
    this.refId,
    this.target,
    this.user,
    this.serializer,
  });

  QuickLinkSeri.fromJson(dynamic json) {
    id = json["id"];
    userId = json["user_id"];
    organizationId = json["organization_id"];
    type = json["type"];
    icon = json["icon"];
    title = json["title"];
    url = json["url"];
    orderNum = json["order_num"];
    targetId = json["target_id"];
    targetType = json["target_type"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    refId = json["ref_id"];
    target = json["target"];
    user = json["user"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["user_id"] = userId;
    map["organization_id"] = organizationId;
    map["type"] = type;
    map["icon"] = icon;
    map["title"] = title;
    map["url"] = url;
    map["order_num"] = orderNum;
    map["target_id"] = targetId;
    map["target_type"] = targetType;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["ref_id"] = refId;
    map["target"] = target;
    map["user"] = user;
    map["_serializer"] = serializer;
    return map;
  }
}
