class SearchTopicJson {
  SearchTopicData data;

  SearchTopicJson({this.data});

  SearchTopicJson.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new SearchTopicData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class SearchTopicData {
  String type;
  List<Hits> hits;
  int totalHits;
  int numHits;

  SearchTopicData({this.type, this.hits, this.totalHits, this.numHits});

  SearchTopicData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['hits'] != null) {
      hits = new List<Hits>();
      json['hits'].forEach((v) {
        hits.add(new Hits.fromJson(v));
      });
    }
    totalHits = json['totalHits'];
    numHits = json['numHits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.hits != null) {
      data['hits'] = this.hits.map((v) => v.toJson()).toList();
    }
    data['totalHits'] = this.totalHits;
    data['numHits'] = this.numHits;
    return data;
  }
}

class Hits {
  String id;
  String type;
  String abstract;
  String bookName;
  String groupName;
  String title;
  String iid;
  String url;
  Record rRecord;

  Hits(
      {this.id,
      this.type,
      this.abstract,
      this.bookName,
      this.groupName,
      this.title,
      this.iid,
      this.url,
      this.rRecord});

  Hits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    abstract = json['abstract'];
    bookName = json['book_name'];
    groupName = json['group_name'];
    title = json['title'];
    iid = json['iid'];
    url = json['url'];
    rRecord =
        json['_record'] != null ? new Record.fromJson(json['_record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['abstract'] = this.abstract;
    data['book_name'] = this.bookName;
    data['group_name'] = this.groupName;
    data['title'] = this.title;
    data['iid'] = this.iid;
    data['url'] = this.url;
    if (this.rRecord != null) {
      data['_record'] = this.rRecord.toJson();
    }
    return data;
  }
}

class Record {
  String bodyAsl;
  Meta meta;
  int id;
  int spaceId;
  int iid;
  String title;
  dynamic cover;
  String description;
  dynamic body;
  String format;
  int userId;
  int groupId;
  dynamic milestoneId;
  int assigneeId;
  int public;
  int commentsCount;
  int labelsCount;
  dynamic deletedAt;
  String pinnedAt;
  String closedAt;
  String createdAt;
  String updatedAt;
  Group group;

  Record(
      {this.bodyAsl,
      this.meta,
      this.id,
      this.spaceId,
      this.iid,
      this.title,
      this.cover,
      this.description,
      this.body,
      this.format,
      this.userId,
      this.groupId,
      this.milestoneId,
      this.assigneeId,
      this.public,
      this.commentsCount,
      this.labelsCount,
      this.deletedAt,
      this.pinnedAt,
      this.closedAt,
      this.createdAt,
      this.updatedAt,
      this.group});

  Record.fromJson(Map<String, dynamic> json) {
    bodyAsl = json['body_asl'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    id = json['id'];
    spaceId = json['space_id'];
    iid = json['iid'];
    title = json['title'];
    cover = json['cover'];
    description = json['description'];
    body = json['body'];
    format = json['format'];
    userId = json['user_id'];
    groupId = json['group_id'];
    milestoneId = json['milestone_id'];
    assigneeId = json['assignee_id'];
    public = json['public'];
    commentsCount = json['comments_count'];
    labelsCount = json['labels_count'];
    deletedAt = json['deleted_at'];
    pinnedAt = json['pinned_at'];
    closedAt = json['closed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body_asl'] = this.bodyAsl;
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    data['id'] = this.id;
    data['space_id'] = this.spaceId;
    data['iid'] = this.iid;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['description'] = this.description;
    data['body'] = this.body;
    data['format'] = this.format;
    data['user_id'] = this.userId;
    data['group_id'] = this.groupId;
    data['milestone_id'] = this.milestoneId;
    data['assignee_id'] = this.assigneeId;
    data['public'] = this.public;
    data['comments_count'] = this.commentsCount;
    data['labels_count'] = this.labelsCount;
    data['deleted_at'] = this.deletedAt;
    data['pinned_at'] = this.pinnedAt;
    data['closed_at'] = this.closedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.group != null) {
      data['group'] = this.group.toJson();
    }
    return data;
  }
}

class Meta {
  String ip;
  String ua;
  List<Orgs> orgs;

  Meta({this.ip, this.ua, this.orgs});

  Meta.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
    ua = json['ua'];
    if (json['orgs'] != null) {
      orgs = new List<Orgs>();
      json['orgs'].forEach((v) {
        orgs.add(new Orgs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ip'] = this.ip;
    data['ua'] = this.ua;
    if (this.orgs != null) {
      data['orgs'] = this.orgs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orgs {
  int id;
  String login;
  String name;
  String host;

  Orgs({this.id, this.login, this.name, this.host});

  Orgs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    name = json['name'];
    host = json['host'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['name'] = this.name;
    data['host'] = this.host;
    return data;
  }
}

class Group {
  String workId;
  String avatarUrl;
  String smallAvatarUrl;
  String mediumAvatarUrl;
  String largeAvatarUrl;
  bool isActive;
  bool isDeactived;
  bool isBanned;
  bool isExtcontact;
  bool isPaid;
  bool hasPaidBefore;
  int id;
  String type;
  String login;
  String name;
  String description;
  String avatar;
  int public;
  int followersCount;
  int followingCount;
  String scene;
  String createdAt;
  String updatedAt;
  int organizationId;
  int memberLevel;
  String expiredAt;
  int status;

  Group(
      {this.workId,
      this.avatarUrl,
      this.smallAvatarUrl,
      this.mediumAvatarUrl,
      this.largeAvatarUrl,
      this.isActive,
      this.isDeactived,
      this.isBanned,
      this.isExtcontact,
      this.isPaid,
      this.hasPaidBefore,
      this.id,
      this.type,
      this.login,
      this.name,
      this.description,
      this.avatar,
      this.public,
      this.followersCount,
      this.followingCount,
      this.scene,
      this.createdAt,
      this.updatedAt,
      this.organizationId,
      this.memberLevel,
      this.expiredAt,
      this.status});

  Group.fromJson(Map<String, dynamic> json) {
    workId = json['work_id'];
    avatarUrl = json['avatar_url'];
    smallAvatarUrl = json['small_avatar_url'];
    mediumAvatarUrl = json['medium_avatar_url'];
    largeAvatarUrl = json['large_avatar_url'];
    isActive = json['isActive'];
    isDeactived = json['isDeactived'];
    isBanned = json['isBanned'];
    isExtcontact = json['isExtcontact'];
    isPaid = json['isPaid'];
    hasPaidBefore = json['hasPaidBefore'];
    id = json['id'];
    type = json['type'];
    login = json['login'];
    name = json['name'];
    description = json['description'];
    avatar = json['avatar'];
    public = json['public'];
    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    scene = json['scene'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    organizationId = json['organization_id'];
    memberLevel = json['member_level'];
    expiredAt = json['expired_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['work_id'] = this.workId;
    data['avatar_url'] = this.avatarUrl;
    data['small_avatar_url'] = this.smallAvatarUrl;
    data['medium_avatar_url'] = this.mediumAvatarUrl;
    data['large_avatar_url'] = this.largeAvatarUrl;
    data['isActive'] = this.isActive;
    data['isDeactived'] = this.isDeactived;
    data['isBanned'] = this.isBanned;
    data['isExtcontact'] = this.isExtcontact;
    data['isPaid'] = this.isPaid;
    data['hasPaidBefore'] = this.hasPaidBefore;
    data['id'] = this.id;
    data['type'] = this.type;
    data['login'] = this.login;
    data['name'] = this.name;
    data['description'] = this.description;
    data['avatar'] = this.avatar;
    data['public'] = this.public;
    data['followers_count'] = this.followersCount;
    data['following_count'] = this.followingCount;
    data['scene'] = this.scene;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['organization_id'] = this.organizationId;
    data['member_level'] = this.memberLevel;
    data['expired_at'] = this.expiredAt;
    data['status'] = this.status;
    return data;
  }
}
