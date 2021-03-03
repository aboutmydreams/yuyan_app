import 'package:yuyan_app/model/serializer/events/user_lite_seri.dart';

class BookEventSeri {
  int id;
  String type;
  String slug;
  String name;
  int userId;
  String description;
  int itemsCount;
  int likesCount;
  int watchesCount;
  int creatorId;
  int public;
  String createdAt;
  String updatedAt;
  String contentUpdatedAt;
  UserLiteSeri user;
  String sSerializer;

  BookEventSeri({
    this.id,
    this.type,
    this.slug,
    this.name,
    this.userId,
    this.description,
    this.itemsCount,
    this.likesCount,
    this.watchesCount,
    this.creatorId,
    this.public,
    this.createdAt,
    this.updatedAt,
    this.contentUpdatedAt,
    this.user,
    this.sSerializer,
  });

  BookEventSeri.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    type = json['type'];
    slug = json['slug'];
    name = json['name'];
    userId = json['user_id'];
    description = json['description'];
    itemsCount = json['items_count'];
    likesCount = json['likes_count'];
    watchesCount = json['watches_count'];
    creatorId = json['creator_id'];
    public = json['public'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentUpdatedAt = json['content_updated_at'];
    user = UserLiteSeri.fromJson(json['user']);
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['description'] = this.description;
    data['items_count'] = this.itemsCount;
    data['likes_count'] = this.likesCount;
    data['watches_count'] = this.watchesCount;
    data['creator_id'] = this.creatorId;
    data['public'] = this.public;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['content_updated_at'] = this.contentUpdatedAt;
    data['user'] = this.user?.toJson();
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
