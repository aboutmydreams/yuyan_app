class QuickData {
  List<Data> data;

  QuickData({this.data});

  QuickData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  int userId;
  int organizationId;
  String type;
  String icon;
  String title;
  String url;
  int orderNum;
  int targetId;
  String targetType;
  String createdAt;
  String updatedAt;
  String sSerializer;

  Data(
      {this.id,
      this.userId,
      this.organizationId,
      this.type,
      this.icon,
      this.title,
      this.url,
      this.orderNum,
      this.targetId,
      this.targetType,
      this.createdAt,
      this.updatedAt,
      this.sSerializer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    organizationId = json['organization_id'];
    type = json['type'];
    icon = json['icon'];
    title = json['title'];
    url = json['url'];
    orderNum = json['order_num'];
    targetId = json['target_id'];
    targetType = json['target_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['organization_id'] = this.organizationId;
    data['type'] = this.type;
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['url'] = this.url;
    data['order_num'] = this.orderNum;
    data['target_id'] = this.targetId;
    data['target_type'] = this.targetType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
