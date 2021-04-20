class OrganizationSeri {
  int id;
  String login;
  String name;
  int status;
  int public;
  int userId;
  String description;
  String logo;
  dynamic allowIps;
  int allowDingtalkAppEnable;
  int externalEnable;
  int watermarkEnable;
  int passwordEnable;
  int corpSyncNameEnable;
  int documentCopyEnable;
  int shareToOutsideEnable;
  int paymentStatus;
  dynamic size;
  String createdAt;
  String updatedAt;
  String expiredAt;
  dynamic willDeleteAt;
  int maxMember;
  int paymentType;
  bool isPaid;
  int payPackage;
  int grainsSum;
  String host;
  String serializer;

  OrganizationSeri(
      {this.id,
      this.login,
      this.name,
      this.status,
      this.public,
      this.userId,
      this.description,
      this.logo,
      this.allowIps,
      this.allowDingtalkAppEnable,
      this.externalEnable,
      this.watermarkEnable,
      this.passwordEnable,
      this.corpSyncNameEnable,
      this.documentCopyEnable,
      this.shareToOutsideEnable,
      this.paymentStatus,
      this.size,
      this.createdAt,
      this.updatedAt,
      this.expiredAt,
      this.willDeleteAt,
      this.maxMember,
      this.paymentType,
      this.isPaid,
      this.payPackage,
      this.grainsSum,
      this.host,
      this.serializer});

  OrganizationSeri.fromJson(dynamic json) {
    id = json["id"];
    login = json["login"];
    name = json["name"];
    status = json["status"];
    public = json["public"];
    userId = json["user_id"];
    description = json["description"];
    logo = json["logo"];
    allowIps = json["allow_ips"];
    allowDingtalkAppEnable = json["allow_dingtalk_app_enable"];
    externalEnable = json["external_enable"];
    watermarkEnable = json["watermark_enable"];
    passwordEnable = json["password_enable"];
    corpSyncNameEnable = json["corp_sync_name_enable"];
    documentCopyEnable = json["document_copy_enable"];
    shareToOutsideEnable = json["share_to_outside_enable"];
    paymentStatus = json["payment_status"];
    size = json["size"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    expiredAt = json["expired_at"];
    willDeleteAt = json["will_delete_at"];
    maxMember = json["max_member"];
    paymentType = json["payment_type"];
    isPaid = json["isPaid"];
    payPackage = json["pay_package"];
    grainsSum = json["grains_sum"];
    host = json["host"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["login"] = login;
    map["name"] = name;
    map["status"] = status;
    map["public"] = public;
    map["user_id"] = userId;
    map["description"] = description;
    map["logo"] = logo;
    map["allow_ips"] = allowIps;
    map["allow_dingtalk_app_enable"] = allowDingtalkAppEnable;
    map["external_enable"] = externalEnable;
    map["watermark_enable"] = watermarkEnable;
    map["password_enable"] = passwordEnable;
    map["corp_sync_name_enable"] = corpSyncNameEnable;
    map["document_copy_enable"] = documentCopyEnable;
    map["share_to_outside_enable"] = shareToOutsideEnable;
    map["payment_status"] = paymentStatus;
    map["size"] = size;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["expired_at"] = expiredAt;
    map["will_delete_at"] = willDeleteAt;
    map["max_member"] = maxMember;
    map["payment_type"] = paymentType;
    map["isPaid"] = isPaid;
    map["pay_package"] = payPackage;
    map["grains_sum"] = grainsSum;
    map["host"] = host;
    map["_serializer"] = serializer;
    return map;
  }
}
