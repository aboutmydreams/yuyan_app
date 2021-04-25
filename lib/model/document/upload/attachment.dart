class AttachmentSeri {
  int id;
  String filekey;
  String filename;
  String ext;
  String mode;
  int filesize;
  String filemd5;
  int symlink;
  String attachableType;
  int attachableId;
  int userId;
  int spaceId;
  String updatedAt;
  String createdAt;

  AttachmentSeri({
    this.id,
    this.filekey,
    this.filename,
    this.ext,
    this.mode,
    this.filesize,
    this.filemd5,
    this.symlink,
    this.attachableType,
    this.attachableId,
    this.userId,
    this.spaceId,
    this.updatedAt,
    this.createdAt,
  });

  AttachmentSeri.fromJson(dynamic json) {
    id = json["id"];
    filekey = json["filekey"];
    filename = json["filename"];
    ext = json["ext"];
    mode = json["mode"];
    filesize = json["filesize"];
    filemd5 = json["filemd5"];
    symlink = json["symlink"];
    attachableType = json["attachable_type"];
    attachableId = json["attachable_id"];
    userId = json["user_id"];
    spaceId = json["space_id"];
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["filekey"] = filekey;
    map["filename"] = filename;
    map["ext"] = ext;
    map["mode"] = mode;
    map["filesize"] = filesize;
    map["filemd5"] = filemd5;
    map["symlink"] = symlink;
    map["attachable_type"] = attachableType;
    map["attachable_id"] = attachableId;
    map["user_id"] = userId;
    map["space_id"] = spaceId;
    map["updated_at"] = updatedAt;
    map["created_at"] = createdAt;
    return map;
  }
}
