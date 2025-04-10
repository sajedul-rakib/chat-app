import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotification {
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> _requestPermission() async {
    NotificationSettings notificationSettings = await firebaseMessaging
        .requestPermission(alert: true, carPlay: true, announcement: true);

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      log("Permitted");
    } else {
      log("Not get permission");
    }
  }
}
