import 'hits_seri.dart';

class SearchResultSeri {
  String type;
  List<SearchHitSeri> hits;
  int totalHits;
  int numHits;

  SearchResultSeri({
    this.type,
    this.hits,
    this.totalHits,
    this.numHits,
  });

  SearchResultSeri.fromJson(dynamic json) {
    type = json["type"];
    if (json["hits"] != null) {
      hits = [];
      json["hits"].forEach((v) {
        hits.add(SearchHitSeri.fromJson(v));
      });
    }
    totalHits = json["totalHits"];
    numHits = json["numHits"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type"] = type;
    if (hits != null) {
      map["hits"] = hits.map((v) => v.toJson()).toList();
    }
    map["totalHits"] = totalHits;
    map["numHits"] = numHits;
    return map;
  }
}
