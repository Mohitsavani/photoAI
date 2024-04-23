import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'alert_model.dart';
import 'local_notification_service.dart';
import 'notification_navigation.dart';

class FirebaseNotification {
  static final FirebaseNotification instance = FirebaseNotification._internal();

  factory FirebaseNotification() {
    return instance;
  }

  FirebaseNotification._internal();

//==============================================================================
// ** Initialize Firebase App Function **
//==============================================================================

  NotificationData notificationData = NotificationData();
  void getAndroidPermissions() {
    Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }

  initializeApp() async {
    getAndroidPermissions();
    getNotification();
  }

//==============================================================================
// ** Notification State Handler Function **
//==============================================================================

  getNotification() async {
    await FirebaseMessaging.instance.getAPNSToken();
    FirebaseMessaging.instance.getToken().then((token) async {
      print(
        " FCM TOKEN: \n $token",
      );
      print(token);
      await FirebaseMessaging.instance
          .subscribeToTopic("posteriya")
          .then((value) => print("Topic subscribed"));
    }).catchError((onError) {
      print("FCM TOKEN: ERROR $onError");
    });

/*  (1). This method call when app in terminated state and you get a notification
         when you click on notification app open from terminated state
         and you can get notification data in this method.*/
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {}
      },
    );

    Future<void> urlLauncher(String url) async {
      if (await canLaunch(url)) {
        await launch(
          url,
        );
      } else {
        throw 'Could not launch $url';
      }
    }

/*  (2). This method only call when App in foreground it mean app must be opened.*/
    FirebaseMessaging.onMessage.listen(
      (message) {
        String body, title;

        if (message.data.isNotEmpty) {
          String url = message.data['url'];
          urlLauncher(url);
        }
        if (message.notification != null) {
          title = message.notification!.title.toString();
          body = message.notification!.body.toString();
          notificationData = NotificationData(
            type: message.data['type'],
            id: message.data['id'],
          );
          LocalNotificationService.instance
              .createAndDisplayNotification(title, body, notificationData);
        }
      },
    );

/* (3). This method only call when App in background and not terminated(not closed).*/
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        if (message.notification != null) {
          String type = message.data['type'];
          NotificationNavigation.instance.onSelectNotification(type);
        }
      },
    );
  }

  Future<void> getIosPermissions() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      sound: true,
      announcement: true,
      badge: false,
      provisional: true,
      carPlay: false,
      criticalAlert: false,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await handleNotificationPermission(true);
    } else {
      await handleNotificationPermission(false);
      getIosPermissions();
    }
  }

  Future<void> handleNotificationPermission(bool granted) async {
    if (granted) {
      String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      String? fCMToken = await FirebaseMessaging.instance.getToken();
      await FirebaseMessaging.instance
          .subscribeToTopic("emi")
          .then((value) => print("ios Topic subscribed"));
      print("IOS\n$apnsToken\n$fCMToken");
    }
  }
}
