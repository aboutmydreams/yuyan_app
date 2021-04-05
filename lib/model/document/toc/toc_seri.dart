class TocSeri {
  String type;
  String title;
  String uuid;
  String url;
  String prevUuid;
  String siblingUuid;
  String childUuid;
  String parentUuid;
  int docId;
  int level;
  int id;
  int openWindow;
  int visible;

  TocSeri({
    this.type,
    this.title,
    this.uuid,
    this.url,
    this.prevUuid,
    this.siblingUuid,
    this.childUuid,
    this.parentUuid,
    this.docId,
    this.level,
    this.id,
    this.openWindow,
    this.visible,
  });

  TocSeri.fromJson(dynamic json) {
    type = json["type"];
    title = json["title"];
    uuid = json["uuid"];
    url = json["url"];
    prevUuid = json["prev_uuid"];
    siblingUuid = json["sibling_uuid"];
    childUuid = json["child_uuid"];
    parentUuid = json["parent_uuid"];
    docId = (json["doc_id"] is String) ? null : json["doc_id"];
    level = json["level"];
    id = (json["id"] is String) ? null : json["id"];
    openWindow = json["open_window"];
    visible = json["visible"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type"] = type;
    map["title"] = title;
    map["uuid"] = uuid;
    map["url"] = url;
    map["prev_uuid"] = prevUuid;
    map["sibling_uuid"] = siblingUuid;
    map["child_uuid"] = childUuid;
    map["parent_uuid"] = parentUuid;
    map["doc_id"] = docId;
    map["level"] = level;
    map["id"] = id;
    map["open_window"] = openWindow;
    map["visible"] = visible;
    return map;
  }
}
