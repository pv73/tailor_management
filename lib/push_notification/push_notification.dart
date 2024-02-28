import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    log("handleBackgroundMessage Message: Title: ${message.notification!.title}");
    log("handleBackgroundMessage Des: ${message.notification!.body}");
  }
}

Future<void> OpenApp(RemoteMessage message) async {
  if (message.notification != null) {
    log("OpenApp Message: Title: ${message.notification!.title}");
    log("OpenApp Des: ${message.notification!.body}");
  }
}

Future<void> onMessage(RemoteMessage message) async {
  if (message.notification != null) {
    log("onMessage Message: Title: ${message.notification!.title}");
    log("onMessage Des: ${message.notification!.body}");
    log("onMessage sender Id: ${message.senderId}");
    log("onMessage Url: ${message.notification!.android}");
  }
}

class Push_Notification {
  static Future<void> initNotifications() async {
    NotificationSettings notificationSettings = await FirebaseMessaging.instance.requestPermission();


    if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
      final fCMToken = await FirebaseMessaging.instance.getToken();
      log("Token: ${fCMToken}");
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(OpenApp);
      FirebaseMessaging.onMessage.listen(onMessage);
    }
  }
}
