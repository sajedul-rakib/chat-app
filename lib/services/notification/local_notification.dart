import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma("vm:entry-point")
Future<void>_backgroundMessageHandler(RemoteMessage message)async{
  await FlutterNotification.instance.setupFlutterLocalNotification();
  await FlutterNotification.instance.showNotification(message);
}

class FlutterNotification {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static String? fcmToken;
  final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();

  bool _isFlutterLocalNotificationInitialize = false;

  FlutterNotification._();

  static final FlutterNotification instance = FlutterNotification._();


  Future<void> initialize()async{
    
    //background message
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
    //take user permission
    _takePermission();

    //setup local notification
    _massageHandler();

    //get fcm token

    final deviceToken= await _messaging.getToken();

    if(deviceToken!=null){
      fcmToken=deviceToken;
    }
  }

  //take permission to show notification to the user device
  Future<void> _takePermission() async {
    final NotificationSettings notificationSettings =
        await _messaging.requestPermission(
            badge: true, alert: true, sound: true, provisional: false);

    log(notificationSettings.authorizationStatus.toString());
  }

  //set local notification
  Future<void> setupFlutterLocalNotification() async {
    if (_isFlutterLocalNotificationInitialize) {
      return;
    }

    //android setup
    const channel = AndroidNotificationChannel(
        "high_importance_channel", "High Importance Channel",
        description: "This is user for important notification",
        importance: Importance.high);

    await _localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings settings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    //ios setup
    final DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings();

    //local notification initialization
    final initializationSettings = InitializationSettings(
        android: settings, iOS: darwinInitializationSettings);

    //flutter local notification setup
    await _localNotification.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (data) {});

    _isFlutterLocalNotificationInitialize = true;
  }

  //show notification
  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _localNotification.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
                "high_importance_channel", "High Importance Notifications",
                channelDescription:
                    "This channel used for important notification",
                importance: Importance.high,
                priority: Priority.high,
                icon: '@mipmap/ic_launcher'),
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: message.data.toString());
    }
  }

  //setup massage handler
  Future<void> _massageHandler() async {
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });

    //background message
    FirebaseMessaging.onMessageOpenedApp.listen(_backgroundNotification);
  }

  //handle background notification
  void _backgroundNotification(RemoteMessage message) {}
}
