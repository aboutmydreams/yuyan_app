
class UserProfileSeri {
  dynamic notificationSettings;
  dynamic events;
  dynamic versionSettings;
  int id;
  int spaceId;
  int userId;
  String location;
  String jobTitle;
  dynamic department;
  int lastEventId;
  dynamic firstQuicklinkAt;
  String appSettings;
  String createdAt;
  String updatedAt;

  UserProfileSeri({
      this.notificationSettings, 
      this.events,
      this.versionSettings, 
      this.id, 
      this.spaceId, 
      this.userId, 
      this.location, 
      this.jobTitle, 
      this.department, 
      this.lastEventId, 
      this.firstQuicklinkAt, 
      this.appSettings, 
      this.createdAt, 
      this.updatedAt});

  UserProfileSeri.fromJson(dynamic json) {
    notificationSettings = json["notification_settings"];
    events = json["events"];
    versionSettings = json["version_settings"];
    id = json["id"];
    spaceId = json["space_id"];
    userId = json["user_id"];
    location = json["location"];
    jobTitle = json["job_title"];
    department = json["department"];
    lastEventId = json["last_event_id"];
    firstQuicklinkAt = json["first_quicklink_at"];
    appSettings = json["app_settings"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["notification_settings"] = notificationSettings;
    map["events"] = events;
    map["version_settings"] = versionSettings;
    map["id"] = id;
    map["space_id"] = spaceId;
    map["user_id"] = userId;
    map["location"] = location;
    map["job_title"] = jobTitle;
    map["department"] = department;
    map["last_event_id"] = lastEventId;
    map["first_quicklink_at"] = firstQuicklinkAt;
    map["app_settings"] = appSettings;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }

}