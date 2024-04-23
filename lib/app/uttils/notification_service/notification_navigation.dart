import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class NotificationNavigation {
  static final NotificationNavigation instance =
      NotificationNavigation._internal();

  factory NotificationNavigation() {
    return instance;
  }

  NotificationNavigation._internal();

  Future onSelectNotification(String? payload) async {
    if (payload != null) {
      getPageOnNotificationTap(payload);
    }
  }

  onPage(String page, {dynamic arguments}) {
    Get.toNamed(page, arguments: arguments);
  }

  getPageOnNotificationTap(String payload) {
    switch (payload) {
      case "Home":
        onPage(Routes.HOME);
        break;
    }
  }
}
