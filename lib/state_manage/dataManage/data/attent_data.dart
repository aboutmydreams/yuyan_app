class AttentData {
  List<Data> data;
  int offset;

  AttentData({this.data, this.offset});

  AttentData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['offset'] = this.offset;
    return data;
  }
}

class Data {
  String who;
  int userId;
  String login;
  String avatarUrl;
  String did;
  String when;
  String subjectType;
  List<Event> event;

  Data(
      {this.who,
      this.userId,
      this.login,
      this.avatarUrl,
      this.did,
      this.when,
      this.subjectType,
      this.event});

  Data.fromJson(Map<String, dynamic> json) {
    who = json['who'];
    userId = json['user_id'];
    login = json['login'];
    avatarUrl = json['avatar_url'];
    did = json['did'];
    when = json['when'];
    subjectType = json['subject_type'];
    if (json['event'] != null) {
      event = new List<Event>();
      json['event'].forEach((v) {
        event.add(new Event.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['who'] = this.who;
    data['user_id'] = this.userId;
    data['login'] = this.login;
    data['avatar_url'] = this.avatarUrl;
    data['did'] = this.did;
    data['when'] = this.when;
    data['subject_type'] = this.subjectType;
    if (this.event != null) {
      data['event'] = this.event.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Event {
  String title;
  String description;
  String image;
  String avatarUrl;
  int count;
  String url;
  int bookId;

  Event(
      {this.title,
      this.description,
      this.image,
      this.avatarUrl,
      this.count,
      this.url,
      this.bookId});

  Event.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
    avatarUrl = json['avatar_url'];
    count = json['count'];
    url = json['url'];
    bookId = json['book_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['avatar_url'] = this.avatarUrl;
    data['count'] = this.count;
    data['url'] = this.url;
    data['book_id'] = this.bookId;
    return data;
  }
}
