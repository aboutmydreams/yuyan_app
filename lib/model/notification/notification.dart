import 'notification_item.dart';

class NotificationSeri {
  int normalCount;
  String listType;
  List<NotificationItemSeri> notifications;

  NotificationSeri({this.normalCount, this.listType, this.notifications});

  NotificationSeri.fromJson(dynamic json) {
    normalCount = json["normalCount"];
    listType = json["list_type"];
    if (json["notifications"] != null) {
      notifications = [];
      json["notifications"].forEach((v) {
        notifications.add(NotificationItemSeri.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["normalCount"] = normalCount;
    map["list_type"] = listType;
    if (notifications != null) {
      map["notifications"] = notifications.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
