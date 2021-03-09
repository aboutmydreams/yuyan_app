class DocletSeri {
  int id;
  int draftVersion;
  int status;
  String contentUpdatedAt;
  int lastEditorId;
  String category;
  String format;
  String type;
  String targetType;
  int targetId;
  String body;
  String bodyDraft;
  String bodyAsl;
  String bodyDraftAsl;
  String createdAt;
  String updatedAt;
  dynamic publishedAt;
  dynamic meta;
  dynamic editorMeta;
  dynamic editorMetaDraft;
  String serializer;

  DocletSeri({
    this.id,
    this.draftVersion,
    this.status,
    this.contentUpdatedAt,
    this.lastEditorId,
    this.category,
    this.format,
    this.type,
    this.targetType,
    this.targetId,
    this.body,
    this.bodyDraft,
    this.bodyAsl,
    this.bodyDraftAsl,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.meta,
    this.editorMeta,
    this.editorMetaDraft,
    this.serializer,
  });

  DocletSeri.fromJson(dynamic json) {
    id = json["id"];
    draftVersion = json["draft_version"];
    status = json["status"];
    contentUpdatedAt = json["content_updated_at"];
    lastEditorId = json["last_editor_id"];
    category = json["category"];
    format = json["format"];
    type = json["type"];
    targetType = json["target_type"];
    targetId = json["target_id"];
    body = json["body"];
    bodyDraft = json["body_draft"];
    bodyAsl = json["body_asl"];
    bodyDraftAsl = json["body_draft_asl"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    publishedAt = json["published_at"];
    meta = json["meta"];
    editorMeta = json["editor_meta"];
    editorMetaDraft = json["editor_meta_draft"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["draft_version"] = draftVersion;
    map["status"] = status;
    map["content_updated_at"] = contentUpdatedAt;
    map["last_editor_id"] = lastEditorId;
    map["category"] = category;
    map["format"] = format;
    map["type"] = type;
    map["target_type"] = targetType;
    map["target_id"] = targetId;
    map["body"] = body;
    map["body_draft"] = bodyDraft;
    map["body_asl"] = bodyAsl;
    map["body_draft_asl"] = bodyDraftAsl;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["published_at"] = publishedAt;
    map["meta"] = meta;
    map["editor_meta"] = editorMeta;
    map["editor_meta_draft"] = editorMetaDraft;
    map["_serializer"] = serializer;
    return map;
  }
}
