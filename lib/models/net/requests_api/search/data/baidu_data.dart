class BaiduJson {
  String q;
  bool p;
  List<G> g;
  String slid;
  String queryid;

  BaiduJson({this.q, this.p, this.g, this.slid, this.queryid});

  BaiduJson.fromJson(Map<String, dynamic> json) {
    q = json['q'];
    p = json['p'];
    if (json['g'] != null) {
      g = new List<G>();
      json['g'].forEach((v) {
        g.add(new G.fromJson(v));
      });
    }
    slid = json['slid'];
    queryid = json['queryid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['q'] = this.q;
    data['p'] = this.p;
    if (this.g != null) {
      data['g'] = this.g.map((v) => v.toJson()).toList();
    }
    data['slid'] = this.slid;
    data['queryid'] = this.queryid;
    return data;
  }
}

class G {
  String type;
  String sa;
  String q;

  G({this.type, this.sa, this.q});

  G.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    sa = json['sa'];
    q = json['q'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['sa'] = this.sa;
    data['q'] = this.q;
    return data;
  }
}
