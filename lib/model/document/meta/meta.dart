import 'orgs.dart';

class MetaSeri {
  String ip;
  String ua;
  List<MetaOrg> orgs;

  MetaSeri({this.ip, this.ua, this.orgs});

  MetaSeri.fromJson(dynamic json) {
    ip = json["ip"];
    ua = json["ua"];
    if (json["orgs"] != null) {
      orgs = [];
      json["orgs"].forEach((v) {
        orgs.add(MetaOrg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ip"] = ip;
    map["ua"] = ua;
    if (orgs != null) {
      map["orgs"] = orgs.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
