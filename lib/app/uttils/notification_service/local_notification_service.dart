import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'alert_model.dart';
import 'notification_navigation.dart';

class LocalNotificationService {
  static final LocalNotificationService instance =
      LocalNotificationService._internal();

  factory LocalNotificationService() {
    return instance;
  }

  LocalNotificationService._internal();

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

//==============================================================================
// ** Local Notification initialize Function **
//==============================================================================

  initialize() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) => NotificationNavigation
          .instance
          .onSelectNotification(payload.toString()),
      onDidReceiveBackgroundNotificationResponse: (payload) =>
          NotificationNavigation.instance
              .onSelectNotification(payload.toString()),
    );
  }

//==============================================================================
// ** Display Local Notification Function **
//==============================================================================

  Future<void> createAndDisplayNotification(
    String title,
    String body,
    NotificationData notificationData,
  ) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "Festiva Alerts",
        "Festiva Alerts App Channel",
        importance: Importance.max,
        priority: Priority.high,
        icon: "@mipmap/ic_launcher",
      );
      const iOSPlatformChannelSpecifics =
          DarwinNotificationDetails(sound: "default", presentAlert: true);

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      await _notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: '${notificationData.toJson()}',
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
