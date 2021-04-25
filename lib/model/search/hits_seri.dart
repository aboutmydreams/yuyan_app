import 'package:yuyan_app/model/serializer/serializer.dart';

class SearchHitSeri {
  String id;
  String type;
  String abstract;
  String bookName;
  String groupName;
  String updatedAt;
  String title;
  String slug;
  String url;
  Serializer record;

  SearchHitSeri({
    this.id,
    this.type,
    this.abstract,
    this.bookName,
    this.groupName,
    this.updatedAt,
    this.title,
    this.slug,
    this.url,
    this.record,
  });

  SearchHitSeri.fromJson(dynamic json) {
    id = json["id"];
    type = json["type"];
    abstract = json["abstract"];
    bookName = json["book_name"];
    groupName = json["group_name"];
    updatedAt = json["updated_at"];
    title = json["title"];
    slug = json["slug"];
    url = json["url"];
    record = json["_record"] != null ? Serializer.fromJson(json["_record"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["type"] = type;
    map["abstract"] = abstract;
    map["book_name"] = bookName;
    map["group_name"] = groupName;
    map["updated_at"] = updatedAt;
    map["title"] = title;
    map["slug"] = slug;
    map["url"] = url;
    if (record != null) {
      map["_record"] = record.toJson();
    }
    return map;
  }
}
