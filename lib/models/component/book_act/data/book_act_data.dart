class BookArtboard {
  List<Actboard> actboard;

  BookArtboard({this.actboard});

  BookArtboard.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      actboard = new List<Actboard>();
      json['data'].forEach((v) {
        actboard.add(new Actboard.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> actboard = new Map<String, dynamic>();
    if (this.actboard != null) {
      actboard['actboard'] = this.actboard.map((v) => v.toJson()).toList();
    }
    return actboard;
  }
}

class Actboard {
  int id;
  String name;
  int sort;
  String artboardType;
  dynamic pinnedAt;
  String createdAt;
  String updatedAt;
  String contentUpdatedAt;
  List<Artboards> artboards;
  String sSerializer;

  Actboard(
      {this.id,
      this.name,
      this.sort,
      this.artboardType,
      this.pinnedAt,
      this.createdAt,
      this.updatedAt,
      this.contentUpdatedAt,
      this.artboards,
      this.sSerializer});

  Actboard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sort = json['sort'];
    artboardType = json['artboard_type'];
    pinnedAt = json['pinned_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentUpdatedAt = json['content_updated_at'];
    if (json['artboards'] != null) {
      artboards = new List<Artboards>();
      json['artboards'].forEach((v) {
        artboards.add(new Artboards.fromJson(v));
      });
    }
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> actboard = new Map<String, dynamic>();
    actboard['id'] = this.id;
    actboard['name'] = this.name;
    actboard['sort'] = this.sort;
    actboard['artboard_type'] = this.artboardType;
    actboard['pinned_at'] = this.pinnedAt;
    actboard['created_at'] = this.createdAt;
    actboard['updated_at'] = this.updatedAt;
    actboard['content_updated_at'] = this.contentUpdatedAt;
    if (this.artboards != null) {
      actboard['artboards'] = this.artboards.map((v) => v.toJson()).toList();
    }
    actboard['_serializer'] = this.sSerializer;
    return actboard;
  }
}

class Artboards {
  int id;
  int artboardGroupId;
  int assetId;
  int assetVersionId;
  int sort;
  String image;
  dynamic smallImage;
  String labelMapUrl;
  String name;
  int width;
  int height;
  int commentsCount;
  String createdAt;
  String updatedAt;
  dynamic contentUpdatedAt;
  dynamic artboardGroup;
  dynamic user;
  dynamic book;
  String sSerializer;

  Artboards(
      {this.id,
      this.artboardGroupId,
      this.assetId,
      this.assetVersionId,
      this.sort,
      this.image,
      this.smallImage,
      this.labelMapUrl,
      this.name,
      this.width,
      this.height,
      this.commentsCount,
      this.createdAt,
      this.updatedAt,
      this.contentUpdatedAt,
      this.artboardGroup,
      this.user,
      this.book,
      this.sSerializer});

  Artboards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    artboardGroupId = json['artboard_group_id'];
    assetId = json['asset_id'];
    assetVersionId = json['asset_version_id'];
    sort = json['sort'];
    image = json['image'];
    smallImage = json['small_image'];
    labelMapUrl = json['label_map_url'];
    name = json['name'];
    width = json['width'];
    height = json['height'];
    commentsCount = json['comments_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentUpdatedAt = json['content_updated_at'];
    artboardGroup = json['artboard_group'];
    user = json['user'];
    book = json['book'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> actboard = new Map<String, dynamic>();
    actboard['id'] = this.id;
    actboard['artboard_group_id'] = this.artboardGroupId;
    actboard['asset_id'] = this.assetId;
    actboard['asset_version_id'] = this.assetVersionId;
    actboard['sort'] = this.sort;
    actboard['image'] = this.image;
    actboard['small_image'] = this.smallImage;
    actboard['label_map_url'] = this.labelMapUrl;
    actboard['name'] = this.name;
    actboard['width'] = this.width;
    actboard['height'] = this.height;
    actboard['comments_count'] = this.commentsCount;
    actboard['created_at'] = this.createdAt;
    actboard['updated_at'] = this.updatedAt;
    actboard['content_updated_at'] = this.contentUpdatedAt;
    actboard['artboard_group'] = this.artboardGroup;
    actboard['user'] = this.user;
    actboard['book'] = this.book;
    actboard['_serializer'] = this.sSerializer;
    return actboard;
  }
}
