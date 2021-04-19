import 'package:yuyan_app/model/document/doc_detail/artboard_detail_seri.dart';

class ArtboardSeri {
  int id;
  String name;
  int sort;
  String artboardType;
  Null pinnedAt;
  String createdAt;
  String updatedAt;
  String contentUpdatedAt;
  List<ArtboardDetailSeri> artboards;
  String sSerializer;

  ArtboardSeri({
    this.id,
    this.name,
    this.sort,
    this.artboardType,
    this.pinnedAt,
    this.createdAt,
    this.updatedAt,
    this.contentUpdatedAt,
    this.artboards,
    this.sSerializer,
  });

  ArtboardSeri.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sort = json['sort'];
    artboardType = json['artboard_type'];
    pinnedAt = json['pinned_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentUpdatedAt = json['content_updated_at'];
    if (json['artboards'] != null) {
      artboards = <ArtboardDetailSeri>[];
      json['artboards'].forEach((v) {
        artboards.add(ArtboardDetailSeri.fromJson(v));
      });
    }
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sort'] = this.sort;
    data['artboard_type'] = this.artboardType;
    data['pinned_at'] = this.pinnedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['content_updated_at'] = this.contentUpdatedAt;
    if (this.artboards != null) {
      data['artboards'] = this.artboards.map((v) => v.toJson()).toList();
    }
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
