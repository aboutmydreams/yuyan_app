import '../book.dart';

class BookStackSeri {
  int id;
  String createdAt;
  String updatedAt;
  int userId;
  int displayType;
  String name;
  int rank;
  bool isDefault;
  List<BookSeri> books;
  String serializer;

  BookStackSeri({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.displayType,
    this.name,
    this.rank,
    this.isDefault,
    this.books,
    this.serializer,
  });

  BookStackSeri.fromJson(dynamic json) {
    id = json["id"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    userId = json["user_id"];
    displayType = json["display_type"];
    name = json["name"];
    rank = json["rank"];
    isDefault = json["is_default"];
    if (json["books"] != null) {
      books = [];
      json["books"].forEach((v) {
        books.add(BookSeri.fromJson(v));
      });
    }
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["user_id"] = userId;
    map["display_type"] = displayType;
    map["name"] = name;
    map["rank"] = rank;
    map["is_default"] = isDefault;
    if (books != null) {
      map["books"] = books.map((v) => v.toJson()).toList();
    }
    map["_serializer"] = serializer;
    return map;
  }
}
