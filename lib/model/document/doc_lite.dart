import '../user/user.dart';
import 'book.dart';

class DocLiteSeri {
  int id;
  String type;
  dynamic subType;
  String title;
  String slug;
  String description;
  dynamic cover;
  int wordCount;
  int userId;
  int bookId;
  int public;
  String contentUpdatedAt;
  String createdAt;
  String updatedAt;
  String publishedAt;
  String firstPublishedAt;
  int readStatus;
  int viewStatus;
  UserSeri user;
  BookSeri book;
  String serializer;

  DocLiteSeri({
    this.id,
    this.type,
    this.subType,
    this.title,
    this.slug,
    this.description,
    this.cover,
    this.wordCount,
    this.userId,
    this.bookId,
    this.public,
    this.contentUpdatedAt,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.firstPublishedAt,
    this.readStatus,
    this.viewStatus,
    this.user,
    this.book,
    this.serializer,
  });

  DocLiteSeri.fromJson(dynamic json) {
    id = json["id"];
    type = json["type"];
    subType = json["sub_type"];
    title = json["title"];
    slug = json["slug"];
    description = json["description"];
    cover = json["cover"];
    wordCount = json["word_count"];
    userId = json["user_id"];
    bookId = json["book_id"];
    public = json["public"];
    contentUpdatedAt = json["content_updated_at"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    publishedAt = json["published_at"];
    firstPublishedAt = json["first_published_at"];
    readStatus = json["read_status"];
    viewStatus = json["view_status"];
    user = json["user"] != null ? UserSeri.fromJson(json["user"]) : null;
    book = json["book"] != null ? BookSeri.fromJson(json["book"]) : null;
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["type"] = type;
    map["sub_type"] = subType;
    map["title"] = title;
    map["slug"] = slug;
    map["description"] = description;
    map["cover"] = cover;
    map["word_count"] = wordCount;
    map["user_id"] = userId;
    map["book_id"] = bookId;
    map["public"] = public;
    map["content_updated_at"] = contentUpdatedAt;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["published_at"] = publishedAt;
    map["first_published_at"] = firstPublishedAt;
    map["read_status"] = readStatus;
    map["view_status"] = viewStatus;
    if (user != null) {
      map["user"] = user.toJson();
    }
    if (book != null) {
      map["book"] = book.toJson();
    }
    map["_serializer"] = serializer;
    return map;
  }
}
