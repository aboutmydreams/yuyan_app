class NoteJson {
  Meta meta;
  List<Data> data;

  NoteJson({this.meta, this.data});

  NoteJson.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  bool hasMore;
  Mirror mirror;

  Meta({this.hasMore, this.mirror});

  Meta.fromJson(Map<String, dynamic> json) {
    hasMore = json['hasMore'];
    mirror =
        json['mirror'] != null ? new Mirror.fromJson(json['mirror']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasMore'] = this.hasMore;
    if (this.mirror != null) {
      data['mirror'] = this.mirror.toJson();
    }
    return data;
  }
}

class Mirror {
  int id;
  int docletId;
  int userId;
  String description;
  dynamic contentUpdatedAt;
  dynamic firstPublishedAt;
  String updatedAt;
  String createdAt;
  Doclet doclet;
  dynamic saveFrom;
  int public;
  String slug;
  int commentsCount;
  int likesCount;
  bool hasImage;
  bool hasTodo;
  bool hasBookmark;
  bool hasAttachment;
  bool isPublic;
  String sSerializer;

  Mirror(
      {this.id,
      this.docletId,
      this.userId,
      this.description,
      this.contentUpdatedAt,
      this.firstPublishedAt,
      this.updatedAt,
      this.createdAt,
      this.doclet,
      this.saveFrom,
      this.public,
      this.slug,
      this.commentsCount,
      this.likesCount,
      this.hasImage,
      this.hasTodo,
      this.hasBookmark,
      this.hasAttachment,
      this.isPublic,
      this.sSerializer});

  Mirror.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    docletId = json['doclet_id'];
    userId = json['user_id'];
    description = json['description'];
    contentUpdatedAt = json['content_updated_at'];
    firstPublishedAt = json['first_published_at'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    doclet =
        json['doclet'] != null ? new Doclet.fromJson(json['doclet']) : null;
    saveFrom = json['save_from'];
    public = json['public'];
    slug = json['slug'];
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
    hasImage = json['has_image'];
    hasTodo = json['has_todo'];
    hasBookmark = json['has_bookmark'];
    hasAttachment = json['has_attachment'];
    isPublic = json['is_public'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doclet_id'] = this.docletId;
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['content_updated_at'] = this.contentUpdatedAt;
    data['first_published_at'] = this.firstPublishedAt;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    if (this.doclet != null) {
      data['doclet'] = this.doclet.toJson();
    }
    data['save_from'] = this.saveFrom;
    data['public'] = this.public;
    data['slug'] = this.slug;
    data['comments_count'] = this.commentsCount;
    data['likes_count'] = this.likesCount;
    data['has_image'] = this.hasImage;
    data['has_todo'] = this.hasTodo;
    data['has_bookmark'] = this.hasBookmark;
    data['has_attachment'] = this.hasAttachment;
    data['is_public'] = this.isPublic;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}

class Doclet {
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
  String sSerializer;

  Doclet(
      {this.id,
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
      this.sSerializer});

  Doclet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    draftVersion = json['draft_version'];
    status = json['status'];
    contentUpdatedAt = json['content_updated_at'];
    lastEditorId = json['last_editor_id'];
    category = json['category'];
    format = json['format'];
    type = json['type'];
    targetType = json['target_type'];
    targetId = json['target_id'];
    body = json['body'];
    bodyDraft = json['body_draft'];
    bodyAsl = json['body_asl'];
    bodyDraftAsl = json['body_draft_asl'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    publishedAt = json['published_at'];
    meta = json['meta'];
    editorMeta = json['editor_meta'];
    editorMetaDraft = json['editor_meta_draft'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['draft_version'] = this.draftVersion;
    data['status'] = this.status;
    data['content_updated_at'] = this.contentUpdatedAt;
    data['last_editor_id'] = this.lastEditorId;
    data['category'] = this.category;
    data['format'] = this.format;
    data['type'] = this.type;
    data['target_type'] = this.targetType;
    data['target_id'] = this.targetId;
    data['body'] = this.body;
    data['body_draft'] = this.bodyDraft;
    data['body_asl'] = this.bodyAsl;
    data['body_draft_asl'] = this.bodyDraftAsl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['published_at'] = this.publishedAt;
    data['meta'] = this.meta;
    data['editor_meta'] = this.editorMeta;
    data['editor_meta_draft'] = this.editorMetaDraft;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}

class Data {
  int id;
  int docletId;
  int userId;
  String description;
  String contentUpdatedAt;
  String firstPublishedAt;
  String updatedAt;
  String createdAt;
  Doclet doclet;
  dynamic saveFrom;
  int public;
  String slug;
  int commentsCount;
  int likesCount;
  bool hasImage;
  bool hasTodo;
  bool hasBookmark;
  bool hasAttachment;
  bool isPublic;
  String sSerializer;

  Data(
      {this.id,
      this.docletId,
      this.userId,
      this.description,
      this.contentUpdatedAt,
      this.firstPublishedAt,
      this.updatedAt,
      this.createdAt,
      this.doclet,
      this.saveFrom,
      this.public,
      this.slug,
      this.commentsCount,
      this.likesCount,
      this.hasImage,
      this.hasTodo,
      this.hasBookmark,
      this.hasAttachment,
      this.isPublic,
      this.sSerializer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    docletId = json['doclet_id'];
    userId = json['user_id'];
    description = json['description'];
    contentUpdatedAt = json['content_updated_at'];
    firstPublishedAt = json['first_published_at'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    doclet =
        json['doclet'] != null ? new Doclet.fromJson(json['doclet']) : null;
    saveFrom = json['save_from'];
    public = json['public'];
    slug = json['slug'];
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
    hasImage = json['has_image'];
    hasTodo = json['has_todo'];
    hasBookmark = json['has_bookmark'];
    hasAttachment = json['has_attachment'];
    isPublic = json['is_public'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doclet_id'] = this.docletId;
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['content_updated_at'] = this.contentUpdatedAt;
    data['first_published_at'] = this.firstPublishedAt;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    if (this.doclet != null) {
      data['doclet'] = this.doclet.toJson();
    }
    data['save_from'] = this.saveFrom;
    data['public'] = this.public;
    data['slug'] = this.slug;
    data['comments_count'] = this.commentsCount;
    data['likes_count'] = this.likesCount;
    data['has_image'] = this.hasImage;
    data['has_todo'] = this.hasTodo;
    data['has_bookmark'] = this.hasBookmark;
    data['has_attachment'] = this.hasAttachment;
    data['is_public'] = this.isPublic;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
