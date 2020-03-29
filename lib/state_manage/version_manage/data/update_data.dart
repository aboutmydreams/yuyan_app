class UpdateJson {
  int code;
  String msg;
  int updateStatus;
  String versionCode;
  String versionName;
  String iOSVersionName;
  String iOSInstallUrl;
  String uploadTime;
  String modifyContent;
  String downloadUrl;
  int apkSize;
  String apkMd5;

  UpdateJson(
      {this.code,
      this.msg,
      this.updateStatus,
      this.versionCode,
      this.versionName,
      this.iOSVersionName,
      this.iOSInstallUrl,
      this.uploadTime,
      this.modifyContent,
      this.downloadUrl,
      this.apkSize,
      this.apkMd5});

  UpdateJson.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    msg = json['Msg'];
    updateStatus = json['UpdateStatus'];
    versionCode = json['VersionCode'];
    versionName = json['VersionName'];
    iOSVersionName = json['IOSVersionName'];
    iOSInstallUrl = json['IOSInstallUrl'];
    uploadTime = json['UploadTime'];
    modifyContent = json['ModifyContent'];
    downloadUrl = json['DownloadUrl'];
    apkSize = json['ApkSize'];
    apkMd5 = json['ApkMd5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    data['Msg'] = this.msg;
    data['UpdateStatus'] = this.updateStatus;
    data['VersionCode'] = this.versionCode;
    data['VersionName'] = this.versionName;
    data['IOSVersionName'] = this.iOSVersionName;
    data['IOSInstallUrl'] = this.iOSInstallUrl;
    data['UploadTime'] = this.uploadTime;
    data['ModifyContent'] = this.modifyContent;
    data['DownloadUrl'] = this.downloadUrl;
    data['ApkSize'] = this.apkSize;
    data['ApkMd5'] = this.apkMd5;
    return data;
  }
}
