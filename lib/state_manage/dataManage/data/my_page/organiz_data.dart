class OrganizJson {
  List<Organiz> data;

  OrganizJson({this.data});

  OrganizJson.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Organiz>();
      json['data'].forEach((v) {
        data.add(new Organiz.fromJson(v));
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

class Organiz {
  String name;
  String logo;
  String login;
  String host;
  String sSerializer;

  Organiz({this.name, this.logo, this.login, this.host, this.sSerializer});

  Organiz.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
    login = json['login'];
    host = json['host'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['login'] = this.login;
    data['host'] = this.host;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
