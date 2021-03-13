import 'vote_item_seri.dart';

class VoteDetailSeri {
  List<String> voted;
  List<VoteItemSeri> items;
  int userId;

  VoteDetailSeri({this.voted, this.items, this.userId});

  VoteDetailSeri.fromJson(dynamic json) {
    voted = json["voted"] != null ? json["voted"].cast<String>() : [];
    if (json["items"] != null) {
      items = [];
      json["items"].forEach((v) {
        items.add(VoteItemSeri.fromJson(v));
      });
    }
    userId = json["user_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["voted"] = voted;
    if (items != null) {
      map["items"] = items.map((v) => v.toJson()).toList();
    }
    map["user_id"] = userId;
    return map;
  }
}
