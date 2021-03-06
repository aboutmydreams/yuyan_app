class UserProfileSeri {
  dynamic department;
  String jobTitle;
  String location;
  String serializer;

  UserProfileSeri({
      this.department, 
      this.jobTitle, 
      this.location, 
      this.serializer});

  UserProfileSeri.fromJson(dynamic json) {
    department = json["department"];
    jobTitle = json["job_title"];
    location = json["location"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["department"] = department;
    map["job_title"] = jobTitle;
    map["location"] = location;
    map["_serializer"] = serializer;
    return map;
  }

}