import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuyan_app/config/service/api_repository.dart';
import 'package:yuyan_app/model/notification/notification.dart';
import 'package:yuyan_app/model/notification/notification_item.dart';
import 'package:yuyan_app/views/home_tabs/notification/widget/one_notification.dart';

class NotificationService extends GetxService {
  Timer timer;
  NotificationSeri data;
  int lastId = 0;

  showNotification(NotificationItemSeri item) {
    //Notify
    BotToast.showCustomNotification(
      toastBuilder: (cancel) {
        Widget child = Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.hardEdge,
          child: NotificationItemWidget(
            data: item,
            beforeTab: cancel,
          ),
        );
        return child;
      },
      duration: 2.seconds,
    );
  }

  fetch() async {
    debugPrint('check notification');
    try {
      data = await ApiRepository.getNotificationList(
        type: 'unread',
        limit: 1,
      );
      if (data.normalCount > 0) {
        var latest = data.notifications.first;
        if (lastId == 0) {
          lastId = latest.id;
        }
        if (latest.id != lastId) {
          lastId = latest.id;
          showNotification(latest);
        }
      }
    } catch (e) {
      debugPrint('fetch notification: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();

    debugPrint('start: notification service');
    timer = Timer.periodic(
      10.seconds,
      (timer) {
        fetch();
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    timer.cancel();
    debugPrint('stop: notification service');
  }
}
