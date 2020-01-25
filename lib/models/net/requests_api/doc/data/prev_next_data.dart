class PrevNext {
  PrevNextData data;

  PrevNext({this.data});

  PrevNext.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new PrevNextData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class PrevNextData {
  Prev prev;
  Prev next;

  PrevNextData({this.prev, this.next});

  PrevNextData.fromJson(Map<String, dynamic> json) {
    prev = json['prev'] != null ? new Prev.fromJson(json['prev']) : null;
    next = json['next'] != null ? new Prev.fromJson(json['next']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.prev != null) {
      data['prev'] = this.prev.toJson();
    }
    if (this.next != null) {
      data['next'] = this.next.toJson();
    }
    return data;
  }
}

class Prev {
  String title;
  String slug;
  String sSerializer;

  Prev({this.title, this.slug, this.sSerializer});

  Prev.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    sSerializer = json['_serializer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['_serializer'] = this.sSerializer;
    return data;
  }
}
