class PagerSeri {
  PageItemSeri prev;
  PageItemSeri next;

  PagerSeri({
    this.prev,
    this.next,
  });

  PagerSeri.fromJson(dynamic json) {
    prev = json["prev"] != null ? PageItemSeri.fromJson(json["prev"]) : null;
    next = json["next"] != null ? PageItemSeri.fromJson(json["next"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (prev != null) {
      map["prev"] = prev.toJson();
    }
    if (next != null) {
      map["next"] = next.toJson();
    }
    return map;
  }
}

class PageItemSeri {
  String title;
  String slug;
  String serializer;

  PageItemSeri({this.title, this.slug, this.serializer});

  PageItemSeri.fromJson(dynamic json) {
    title = json["title"];
    slug = json["slug"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = title;
    map["slug"] = slug;
    map["_serializer"] = serializer;
    return map;
  }
}
