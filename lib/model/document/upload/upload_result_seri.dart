import 'attachment.dart';

class UploadResultSeri {
  String filekey;
  String extname;
  String mode;
  String url;
  String filename;
  int size;
  String etag;
  int symlink;
  bool isCopy;
  String filemd5;
  int attachmentId;
  String attachableType;
  int attachableId;
  AttachmentSeri attachment;

  UploadResultSeri({
    this.filekey,
    this.extname,
    this.mode,
    this.url,
    this.filename,
    this.size,
    this.etag,
    this.symlink,
    this.isCopy,
    this.filemd5,
    this.attachmentId,
    this.attachableType,
    this.attachableId,
    this.attachment,
  });

  UploadResultSeri.fromJson(dynamic json) {
    filekey = json["filekey"];
    extname = json["extname"];
    mode = json["mode"];
    url = json["url"];
    filename = json["filename"];
    size = json["size"];
    etag = json["etag"];
    symlink = json["symlink"];
    isCopy = json["isCopy"];
    filemd5 = json["filemd5"];
    attachmentId = json["attachment_id"];
    attachableType = json["attachable_type"];
    attachableId = json["attachable_id"];
    attachment = json["attachment"] != null
        ? AttachmentSeri.fromJson(json["attachment"])
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["filekey"] = filekey;
    map["extname"] = extname;
    map["mode"] = mode;
    map["url"] = url;
    map["filename"] = filename;
    map["size"] = size;
    map["etag"] = etag;
    map["symlink"] = symlink;
    map["isCopy"] = isCopy;
    map["filemd5"] = filemd5;
    map["attachment_id"] = attachmentId;
    map["attachable_type"] = attachableType;
    map["attachable_id"] = attachableId;
    if (attachment != null) {
      map["attachment"] = attachment.toJson();
    }
    return map;
  }
}
