import 'package:flutter/cupertino.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/config/storage_manager.dart';
import 'package:yuyan_app/config/viewstate/view_state.dart';
import 'package:yuyan_app/model/notification/notification_item.dart';

abstract class NotificationProvider
    extends BaseSaveListJson<NotificationItemSeri> {
  @override
  List<NotificationItemSeri> convert(json) {
    return (json as List).map((e) => NotificationItemSeri.fromJson(e)).toList();
  }
}

class NotificationUnreadProvider extends NotificationProvider {
  @override
  String get key => 'user_notification_unread';
}

class NotificationReadProvider extends NotificationProvider {
  @override
  String get key => 'user_notification_read';
}

class NotificationSystemProvider extends NotificationProvider {
  @override
  String get key => 'user_notification_system';
}

abstract class NotificationController
    extends FetchRefreshController<NotificationProvider> {
  final String notificationType;

  NotificationController({
    @required this.notificationType,
    @required NotificationProvider provider,
  }) : super(
          initData: provider,
          initialRefresh: true,
          state: ViewState.loading,
        );

  @override
  Future fetchMoreData() {
    int offset = value.data?.length ?? 0;
    return ApiRepository.getNotificationList(
        type: notificationType, offset: offset);
  }

  @override
  Future refreshData() {
    return ApiRepository.getNotificationList(type: notificationType);
  }
}

class NotificationReadController extends NotificationController {
  NotificationReadController()
      : super(
          notificationType: 'readed',
          provider: NotificationReadProvider(),
        );
}

class NotificationUnreadController extends NotificationController {
  NotificationUnreadController()
      : super(
          notificationType: 'unread',
          provider: NotificationUnreadProvider(),
        );
}

class NotificationSystemController extends NotificationController {
  NotificationSystemController()
      : super(
          notificationType: 'system',
          provider: NotificationSystemProvider(),
        );
}
