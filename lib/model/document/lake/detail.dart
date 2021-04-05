class CardDetailSeri {
  String image;
  String title;
  String type;
  String belong;
  String belongUrl;
  String desc;
  String url;
  String targetType;
  String serializer;

  CardDetailSeri({
      this.image, 
      this.title, 
      this.type, 
      this.belong, 
      this.belongUrl, 
      this.desc, 
      this.url, 
      this.targetType, 
      this.serializer});

  CardDetailSeri.fromJson(dynamic json) {
    image = json["image"];
    title = json["title"];
    type = json["type"];
    belong = json["belong"];
    belongUrl = json["belong_url"];
    desc = json["desc"];
    url = json["url"];
    targetType = json["target_type"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["image"] = image;
    map["title"] = title;
    map["type"] = type;
    map["belong"] = belong;
    map["belong_url"] = belongUrl;
    map["desc"] = desc;
    map["url"] = url;
    map["target_type"] = targetType;
    map["_serializer"] = serializer;
    return map;
  }

}