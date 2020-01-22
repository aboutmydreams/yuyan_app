class ProfileData {
  ProData data;

  ProfileData({this.data});

  ProfileData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ProData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ProData {
  dynamic department;
  String jobTitle;
  String location;
  String sSerializer;

  ProData({this.department, this.jobTitle, this.location, this.sSerializer});

  ProData.fromJson(Map<String, dynamic> json) {
    department = json['department'];
    jobTitle = json['job_title'];
    location = json['location'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['department'] = this.department;
    data['job_title'] = this.jobTitle;
    data['location'] = this.location;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
