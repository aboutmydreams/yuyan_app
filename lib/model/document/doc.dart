import 'package:yuyan_app/model/serializer/serializer.dart';

import 'book.dart';
import '../user/user.dart';

class DocSeri {
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
  int viewStatus;
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
  String selectedAt;
  dynamic pinnedAt;
  Serializer meta;
  BookSeri book;
  UserSeri user;
  dynamic lastEditor;
  dynamic share;
  bool isPreimum;
  String serializer;

  DocSeri({
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
    this.viewStatus,
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
    this.selectedAt,
    this.pinnedAt,
    this.meta,
    this.book,
    this.user,
    this.lastEditor,
    this.share,
    this.isPreimum,
    this.serializer,
  });

  DocSeri.fromJson(dynamic json) {
    id = json["id"];
    spaceId = json["space_id"];
    type = json["type"];
    subType = json["sub_type"];
    title = json["title"];
    titleDraft = json["title_draft"];
    tag = json["tag"];
    slug = json["slug"];
    userId = json["user_id"];
    bookId = json["book_id"];
    lastEditorId = json["last_editor_id"];
    cover = json["cover"];
    description = json["description"];
    customDescription = json["custom_description"];
    format = json["format"];
    status = json["status"];
    readStatus = json["read_status"];
    viewStatus = json["view_status"];
    public = json["public"];
    draftVersion = json["draft_version"];
    commentsCount = json["comments_count"];
    likesCount = json["likes_count"];
    contentUpdatedAt = json["content_updated_at"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    publishedAt = json["published_at"];
    firstPublishedAt = json["first_published_at"];
    wordCount = json["word_count"];
    selectedAt = json["selected_at"];
    pinnedAt = json["pinned_at"];
    meta = Serializer.fromJson(json["meta"]);
    book = json["book"] != null ? BookSeri.fromJson(json["book"]) : null;
    user = json["user"] != null ? UserSeri.fromJson(json["user"]) : null;
    lastEditor = json["last_editor"];
    share = json["share"];
    isPreimum = json["isPreimum"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["space_id"] = spaceId;
    map["type"] = type;
    map["sub_type"] = subType;
    map["title"] = title;
    map["title_draft"] = titleDraft;
    map["tag"] = tag;
    map["slug"] = slug;
    map["user_id"] = userId;
    map["book_id"] = bookId;
    map["last_editor_id"] = lastEditorId;
    map["cover"] = cover;
    map["description"] = description;
    map["custom_description"] = customDescription;
    map["format"] = format;
    map["status"] = status;
    map["read_status"] = readStatus;
    map["view_status"] = viewStatus;
    map["public"] = public;
    map["draft_version"] = draftVersion;
    map["comments_count"] = commentsCount;
    map["likes_count"] = likesCount;
    map["content_updated_at"] = contentUpdatedAt;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["published_at"] = publishedAt;
    map["first_published_at"] = firstPublishedAt;
    map["word_count"] = wordCount;
    map["selected_at"] = selectedAt;
    map["pinned_at"] = pinnedAt;
    map["meta"] = meta.raw;
    if (book != null) {
      map["book"] = book.toJson();
    }
    if (user != null) {
      map["user"] = user.toJson();
    }
    map["last_editor"] = lastEditor;
    map["share"] = share;
    map["isPreimum"] = isPreimum;
    map["_serializer"] = serializer;
    return map;
  }
}
