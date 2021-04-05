class LabelSeri {
  int id;
  String name;
  String color;
  String createdAt;
  String updatedAt;
  String serializer;

  LabelSeri({
    this.id,
    this.name,
    this.color,
    this.createdAt,
    this.updatedAt,
    this.serializer,
  });

  LabelSeri.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    color = json["color"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["color"] = color;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["_serializer"] = serializer;
    return map;
  }
}
