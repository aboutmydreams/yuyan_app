class Labels {
  int id;
  int groupId;
  String name;
  String color;
  String createdAt;
  String updatedAt;
  String serializer;

  Labels({
      this.id, 
      this.groupId, 
      this.name, 
      this.color, 
      this.createdAt, 
      this.updatedAt, 
      this.serializer});

  Labels.fromJson(dynamic json) {
    id = json["id"];
    groupId = json["group_id"];
    name = json["name"];
    color = json["color"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["group_id"] = groupId;
    map["name"] = name;
    map["color"] = color;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["_serializer"] = serializer;
    return map;
  }

}