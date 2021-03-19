class SettingSeri {
  String displayType;
  String layoutType;

  SettingSeri({this.displayType});

  SettingSeri.fromJson(json) {
    if (json == null) return;
    displayType = json['displayType'];
    layoutType = json['layoutType'];
  }

  Map toJson() => {
        'displayType': displayType,
        'layoutType': layoutType,
      };
}
