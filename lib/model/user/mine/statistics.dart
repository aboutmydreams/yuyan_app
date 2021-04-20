class StatisticsSeri {
  String bizdate;
  int docCount;
  int likeCount;
  String serializer;

  StatisticsSeri({
      this.bizdate, 
      this.docCount, 
      this.likeCount, 
      this.serializer});

  StatisticsSeri.fromJson(dynamic json) {
    bizdate = json["bizdate"];
    docCount = json["doc_count"];
    likeCount = json["like_count"];
    serializer = json["_serializer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["bizdate"] = bizdate;
    map["doc_count"] = docCount;
    map["like_count"] = likeCount;
    map["_serializer"] = serializer;
    return map;
  }

}