class FlutterNotification {
  static final FlutterNotification _notificationService =
      FlutterNotification._internal();

  factory FlutterNotification() {
    return _notificationService;
  }

  FlutterNotification._internal();

  //Notification initialization
  Future<void> notificationInit() async {}

//firebase messaging

//local messaging
}
