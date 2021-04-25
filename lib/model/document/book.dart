import 'group_home/summary.dart';
import 'meta/ability.dart';
import '../user/user.dart';

class BookSeri {
  int id;
  String type;
  String slug;
  String name;
  int userId;
  String description;
  int public;
  String createdAt;
  String updatedAt;
  String contentUpdatedAt;
  String layout;
  String docViewport;
  dynamic docTypography;
  bool enableAutoPublish;
  UserSeri user;
  dynamic creator;
  String serializer;

  ///book_stack添加
  int itemsCount;
  int likesCount;
  int watchesCount;
  int creatorId;
  MetaAbilitySeri abilities;
  dynamic pinnedAt;
  dynamic archivedAt;
  List<SummarySeri> summary;
  int status;
  dynamic stackId;
  dynamic rank;
  String cover;
  dynamic original;
  int organizationId;

  ///v2 获取知识库详情添加
  String v2toc;
  String v2tocYaml;
  String v2Namespace;

  BookSeri.fromJson(dynamic json) {
    id = json["id"];
    type = json["type"];
    slug = json["slug"];
    name = json["name"];
    userId = json["user_id"];
    description = json["description"];
    public = json["public"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    contentUpdatedAt = json["content_updated_at"];
    layout = json["layout"];
    docViewport = json["doc_viewport"];
    docTypography = json["doc_typography"];
    enableAutoPublish = json["enable_auto_publish"];
    user = json["user"] != null ? UserSeri.fromJson(json["user"]) : null;
    creator = json["creator"];
    serializer = json["_serializer"];

    ///由book_stack添加
    itemsCount = json["items_count"];
    likesCount = json["likes_count"];
    watchesCount = json["watches_count"];
    creatorId = json["creator_id"];
    abilities = json["abilities"] != null
        ? MetaAbilitySeri.fromJson(json["abilities"])
        : null;
    pinnedAt = json["pinned_at"];
    archivedAt = json["archived_at"];
    if (json["summary"] != null) {
      summary = [];
      json["summary"].forEach((v) {
        summary.add(SummarySeri.fromJson(v));
      });
    }
    status = json["status"];
    stackId = json["stack_id"];
    rank = json["rank"];
    cover = json["cover"];
    original = json["original"];
    organizationId = json["organization_id"];

    /// v2 添加
    v2Namespace = json['namespace'];
    v2toc = json['toc'];
    v2tocYaml = json['toc_yml'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["type"] = type;
    map["slug"] = slug;
    map["name"] = name;
    map["user_id"] = userId;
    map["description"] = description;
    map["public"] = public;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["content_updated_at"] = contentUpdatedAt;
    map["layout"] = layout;
    map["doc_viewport"] = docViewport;
    map["doc_typography"] = docTypography;
    map["enable_auto_publish"] = enableAutoPublish;
    if (user != null) {
      map["user"] = user.toJson();
    }
    map["creator"] = creator;
    map["_serializer"] = serializer;

    ///由book_stack添加
    map["items_count"] = itemsCount;
    map["likes_count"] = likesCount;
    map["watches_count"] = watchesCount;
    map["creator_id"] = creatorId;
    if (abilities != null) {
      map["abilities"] = abilities.toJson();
    }
    map["pinned_at"] = pinnedAt;
    map["archived_at"] = archivedAt;
    if (summary != null) {
      map["summary"] = summary.map((v) => v.toJson()).toList();
    }
    map["status"] = status;
    map["stack_id"] = stackId;
    map["rank"] = rank;
    map["cover"] = cover;
    map["original"] = original;
    map["organization_id"] = organizationId;
    return map;
  }
}
