class CardVideoSeri {
  String status;
  String name;
  int size;
  int percent;
  String taskId;
  bool margin;
  String id;
  String videoId;

  CardVideoSeri({
    this.status,
    this.name,
    this.size,
    this.percent,
    this.taskId,
    this.margin,
    this.id,
    this.videoId,
  });

  CardVideoSeri.fromJson(dynamic json) {
    status = json["status"];
    name = json["name"];
    size = json["size"];
    percent = json["percent"];
    taskId = json["taskId"];
    margin = json["margin"];
    id = json["id"];
    videoId = json["videoId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    map["name"] = name;
    map["size"] = size;
    map["percent"] = percent;
    map["taskId"] = taskId;
    map["margin"] = margin;
    map["id"] = id;
    map["videoId"] = videoId;
    return map;
  }
}
