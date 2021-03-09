class CardVideoResSeri {
  String status;
  CardVideoOkSeri info;

  CardVideoResSeri({
    this.status,
    this.info,
  });

  CardVideoResSeri.fromJson(dynamic json) {
    status = json["status"];
    info = json["info"] != null ? CardVideoOkSeri.fromJson(json["info"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    if (info != null) {
      map["info"] = info.toJson();
    }
    return map;
  }
}

class CardVideoOkSeri {
  String type;
  String cover;
  String video;

  CardVideoOkSeri({this.type, this.cover, this.video});

  CardVideoOkSeri.fromJson(dynamic json) {
    type = json["type"];
    cover = json["cover"];
    video = json["video"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type"] = type;
    map["cover"] = cover;
    map["video"] = video;
    return map;
  }
}
