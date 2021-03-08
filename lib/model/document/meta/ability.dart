class MetaAbilitySeri {
  bool read;
  bool update;

  MetaAbilitySeri({
    this.read,
    this.update,
  });

  MetaAbilitySeri.fromJson(dynamic json) {
    read = json["read"];
    update = json["update"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["read"] = read;
    map["update"] = update;
    return map;
  }
}
