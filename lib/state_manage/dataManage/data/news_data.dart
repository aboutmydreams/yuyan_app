class UnreadData {
  Data data;

  UnreadData({this.data});

  UnreadData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int count;
  List<UnreadNewsList> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<UnreadNewsList>();
      json['list'].forEach((v) {
        list.add(new UnreadNewsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnreadNewsList {
  int organizationId;
  String icon;
  String name;
  String host;
  int count;
  bool isSelf;

  UnreadNewsList(
      {this.organizationId,
      this.icon,
      this.name,
      this.host,
      this.count,
      this.isSelf});

  UnreadNewsList.fromJson(Map<String, dynamic> json) {
    organizationId = json['organization_id'];
    icon = json['icon'];
    name = json['name'];
    host = json['host'];
    count = json['count'];
    isSelf = json['isSelf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organization_id'] = this.organizationId;
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['host'] = this.host;
    data['count'] = this.count;
    data['isSelf'] = this.isSelf;
    return data;
  }
}
