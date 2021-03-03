import 'package:yuyan_app/model/serializer/events/user_lite_seri.dart';

class DocEventSeri {
  int id;
  int spaceId;
  String type;
  dynamic subType;
  String title;
  dynamic titleDraft;
  dynamic tag;
  String slug;
  int userId;
  int bookId;
  int lastEditorId;
  String cover;
  String description;
  dynamic customDescription;
  String format;
  int status;
  int readStatus;
  int public;
  int draftVersion;
  int commentsCount;
  int likesCount;
  String contentUpdatedAt;
  String createdAt;
  String updatedAt;
  String publishedAt;
  String firstPublishedAt;
  int wordCount;
  UserLiteSeri user;
  dynamic lastEditor;
  String sSerializer;

  DocEventSeri({
    this.id,
    this.spaceId,
    this.type,
    this.subType,
    this.title,
    this.titleDraft,
    this.tag,
    this.slug,
    this.userId,
    this.bookId,
    this.lastEditorId,
    this.cover,
    this.description,
    this.customDescription,
    this.format,
    this.status,
    this.readStatus,
    this.public,
    this.draftVersion,
    this.commentsCount,
    this.likesCount,
    this.contentUpdatedAt,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.firstPublishedAt,
    this.wordCount,
    this.user,
    this.lastEditor,
    this.sSerializer,
  });

  DocEventSeri.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    spaceId = json['space_id'];
    type = json['type'];
    subType = json['sub_type'];
    title = json['title'];
    titleDraft = json['title_draft'];
    tag = json['tag'];
    slug = json['slug'];
    userId = json['user_id'];
    bookId = json['book_id'];
    lastEditorId = json['last_editor_id'];
    cover = json['cover'];
    description = json['description'];
    customDescription = json['custom_description'];
    format = json['format'];
    status = json['status'];
    readStatus = json['read_status'];
    public = json['public'];
    draftVersion = json['draft_version'];
    commentsCount = json['comments_count'];
    likesCount = json['likes_count'];
    contentUpdatedAt = json['content_updated_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    publishedAt = json['published_at'];
    firstPublishedAt = json['first_published_at'];
    wordCount = json['word_count'];
    user = UserLiteSeri.fromJson(json['user']);
    lastEditor = json['last_editor'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['space_id'] = this.spaceId;
    data['type'] = this.type;
    data['sub_type'] = this.subType;
    data['title'] = this.title;
    data['title_draft'] = this.titleDraft;
    data['tag'] = this.tag;
    data['slug'] = this.slug;
    data['user_id'] = this.userId;
    data['book_id'] = this.bookId;
    data['last_editor_id'] = this.lastEditorId;
    data['cover'] = this.cover;
    data['description'] = this.description;
    data['custom_description'] = this.customDescription;
    data['format'] = this.format;
    data['status'] = this.status;
    data['read_status'] = this.readStatus;
    data['public'] = this.public;
    data['draft_version'] = this.draftVersion;
    data['comments_count'] = this.commentsCount;
    data['likes_count'] = this.likesCount;
    data['content_updated_at'] = this.contentUpdatedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['published_at'] = this.publishedAt;
    data['first_published_at'] = this.firstPublishedAt;
    data['word_count'] = this.wordCount;
    data['user'] = this.user.toJson();
    data['last_editor'] = this.lastEditor;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
