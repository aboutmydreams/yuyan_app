class GroupSeri {
  String workId;
  String avatarUrl;
  bool isActive;
  bool isDeactived;
  bool isBanned;
  bool isExtcontact;
  bool isPaid;
  bool hasPaidBefore;
  int id;
  int spaceId;
  String type;
  String login;
  String name;
  String description;
  dynamic avatar;
  int ownerId;
  int topicsCount;
  int publicTopicsCount;
  int membersCount;
  int booksCount;
  int publicBooksCount;
  int followersCount;
  int followingCount;
  dynamic accountId;
  int role;
  int status;
  int public;
  bool wantsEmail;
  bool wantsMarketingEmail;
  int topicUpdatedAtMs;
  dynamic deletedSlug;
  String language;
  int organizationId;
  dynamic empType;
  dynamic groupDepartmentUpdatedAt;
  int memberLevel;
  dynamic expiredAt;
  String scene;
  String source;
  dynamic maxMember;
  String createdAt;
  String updatedAt;
  int grainsSum;
  dynamic deletedAt;

  GroupSeri({
    this.workId,
    this.avatarUrl,
    this.isActive,
    this.isDeactived,
    this.isBanned,
    this.isExtcontact,
    this.isPaid,
    this.hasPaidBefore,
    this.id,
    this.spaceId,
    this.type,
    this.login,
    this.name,
    this.description,
    this.avatar,
    this.ownerId,
    this.topicsCount,
    this.publicTopicsCount,
    this.membersCount,
    this.booksCount,
    this.publicBooksCount,
    this.followersCount,
    this.followingCount,
    this.accountId,
    this.role,
    this.status,
    this.public,
    this.wantsEmail,
    this.wantsMarketingEmail,
    this.topicUpdatedAtMs,
    this.deletedSlug,
    this.language,
    this.organizationId,
    this.empType,
    this.groupDepartmentUpdatedAt,
    this.memberLevel,
    this.expiredAt,
    this.scene,
    this.source,
    this.maxMember,
    this.createdAt,
    this.updatedAt,
    this.grainsSum,
    this.deletedAt,
  });

  GroupSeri.fromJson(dynamic json) {
    workId = json["work_id"];
    avatarUrl = json["avatar_url"];
    isActive = json["isActive"];
    isDeactived = json["isDeactived"];
    isBanned = json["isBanned"];
    isExtcontact = json["isExtcontact"];
    isPaid = json["isPaid"];
    hasPaidBefore = json["hasPaidBefore"];
    id = json["id"];
    spaceId = json["space_id"];
    type = json["type"];
    login = json["login"];
    name = json["name"];
    description = json["description"];
    avatar = json["avatar"];
    ownerId = json["owner_id"];
    topicsCount = json["topics_count"];
    publicTopicsCount = json["public_topics_count"];
    membersCount = json["members_count"];
    booksCount = json["books_count"];
    publicBooksCount = json["public_books_count"];
    followersCount = json["followers_count"];
    followingCount = json["following_count"];
    accountId = json["account_id"];
    role = json["role"];
    status = json["status"];
    public = json["public"];
    wantsEmail = json["wants_email"];
    wantsMarketingEmail = json["wants_marketing_email"];
    topicUpdatedAtMs = json["topic_updated_at_ms"];
    deletedSlug = json["deleted_slug"];
    language = json["language"];
    organizationId = json["organization_id"];
    empType = json["emp_type"];
    groupDepartmentUpdatedAt = json["group_department_updated_at"];
    memberLevel = json["member_level"];
    expiredAt = json["expired_at"];
    scene = json["scene"];
    source = json["source"];
    maxMember = json["max_member"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    grainsSum = json["grains_sum"];
    deletedAt = json["deleted_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["work_id"] = workId;
    map["avatar_url"] = avatarUrl;
    map["isActive"] = isActive;
    map["isDeactived"] = isDeactived;
    map["isBanned"] = isBanned;
    map["isExtcontact"] = isExtcontact;
    map["isPaid"] = isPaid;
    map["hasPaidBefore"] = hasPaidBefore;
    map["id"] = id;
    map["space_id"] = spaceId;
    map["type"] = type;
    map["login"] = login;
    map["name"] = name;
    map["description"] = description;
    map["avatar"] = avatar;
    map["owner_id"] = ownerId;
    map["topics_count"] = topicsCount;
    map["public_topics_count"] = publicTopicsCount;
    map["members_count"] = membersCount;
    map["books_count"] = booksCount;
    map["public_books_count"] = publicBooksCount;
    map["followers_count"] = followersCount;
    map["following_count"] = followingCount;
    map["account_id"] = accountId;
    map["role"] = role;
    map["status"] = status;
    map["public"] = public;
    map["wants_email"] = wantsEmail;
    map["wants_marketing_email"] = wantsMarketingEmail;
    map["topic_updated_at_ms"] = topicUpdatedAtMs;
    map["deleted_slug"] = deletedSlug;
    map["language"] = language;
    map["organization_id"] = organizationId;
    map["emp_type"] = empType;
    map["group_department_updated_at"] = groupDepartmentUpdatedAt;
    map["member_level"] = memberLevel;
    map["expired_at"] = expiredAt;
    map["scene"] = scene;
    map["source"] = source;
    map["max_member"] = maxMember;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["grains_sum"] = grainsSum;
    map["deleted_at"] = deletedAt;
    return map;
  }
}
