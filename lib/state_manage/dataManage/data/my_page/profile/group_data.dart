class Group {
  List<Data> data;

  Group({this.data});

  Group.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String type;
  String login;
  String name;
  String description;
  String avatarUrl;
  int ownerId;
  int booksCount;
  int publicBooksCount;
  int topicsCount;
  int publicTopicsCount;
  int membersCount;
  int public;
  String scene;
  String createdAt;
  String updatedAt;
  String pinnedAt;
  int groupUserId;
  int groupUserRole;
  int organizationId;
  bool isPaid;
  dynamic organization;
  dynamic owners;
  String sSerializer;

  Data(
      {this.id,
      this.type,
      this.login,
      this.name,
      this.description,
      this.avatarUrl,
      this.ownerId,
      this.booksCount,
      this.publicBooksCount,
      this.topicsCount,
      this.publicTopicsCount,
      this.membersCount,
      this.public,
      this.scene,
      this.createdAt,
      this.updatedAt,
      this.pinnedAt,
      this.groupUserId,
      this.groupUserRole,
      this.organizationId,
      this.isPaid,
      this.organization,
      this.owners,
      this.sSerializer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    login = json['login'];
    name = json['name'];
    description = json['description'];
    avatarUrl = json['avatar_url'];
    ownerId = json['owner_id'];
    booksCount = json['books_count'];
    publicBooksCount = json['public_books_count'];
    topicsCount = json['topics_count'];
    publicTopicsCount = json['public_topics_count'];
    membersCount = json['members_count'];
    public = json['public'];
    scene = json['scene'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pinnedAt = json['pinned_at'];
    groupUserId = json['group_user_id'];
    groupUserRole = json['group_user_role'];
    organizationId = json['organization_id'];
    isPaid = json['isPaid'];
    organization = json['organization'];
    owners = json['owners'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['login'] = this.login;
    data['name'] = this.name;
    data['description'] = this.description;
    data['avatar_url'] = this.avatarUrl;
    data['owner_id'] = this.ownerId;
    data['books_count'] = this.booksCount;
    data['public_books_count'] = this.publicBooksCount;
    data['topics_count'] = this.topicsCount;
    data['public_topics_count'] = this.publicTopicsCount;
    data['members_count'] = this.membersCount;
    data['public'] = this.public;
    data['scene'] = this.scene;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['pinned_at'] = this.pinnedAt;
    data['group_user_id'] = this.groupUserId;
    data['group_user_role'] = this.groupUserRole;
    data['organization_id'] = this.organizationId;
    data['isPaid'] = this.isPaid;
    data['organization'] = this.organization;
    data['owners'] = this.owners;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
