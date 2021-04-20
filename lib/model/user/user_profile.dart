class UserProfileSeri {
  int id;
  int userId;
  String location;
  String jobTitle;
  dynamic department;
  String createdAt;
  String updatedAt;
  String serializer;

  UserProfileSeri({
    this.id,
    this.userId,
    this.location,
    this.jobTitle,
    this.department,
    this.createdAt,
    this.updatedAt,
    this.serializer,
  });

  UserProfileSeri.fromJson(dynamic json) {
    id = json["id"];
    userId = json["user_id"];
    location = json["location"];
    jobTitle = json["job_title"];
    department = json["department"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["user_id"] = userId;
    map["location"] = location;
    map["job_title"] = jobTitle;
    map["department"] = department;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["_serializer"] = serializer;
    return map;
  }
}
