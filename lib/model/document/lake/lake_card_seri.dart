import 'detail.dart';

class LakeCardSeri {
  String src;
  String url;
  String mode;
  bool margin;
  String id;
  CardDetailSeri detail;

  LakeCardSeri({
    this.src,
    this.url,
    this.mode,
    this.margin,
    this.id,
    this.detail,
  });

  LakeCardSeri.fromJson(dynamic json) {
    src = json["src"];
    url = json["url"];
    mode = json["mode"];
    margin = json["margin"];
    id = json["id"];
    detail = json["detail"] != null ? CardDetailSeri.fromJson(json["detail"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["src"] = src;
    map["url"] = url;
    map["mode"] = mode;
    map["margin"] = margin;
    map["id"] = id;
    if (detail != null) {
      map["detail"] = detail.toJson();
    }
    return map;
  }
}
