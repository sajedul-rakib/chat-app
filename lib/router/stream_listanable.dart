import 'dart:async';

import 'package:flutter/material.dart';

class StreamListenable extends ChangeNotifier {
  late final List<StreamSubscription> subcriptions;

  StreamToListenable(List<Stream> stream) {
    subcriptions = [];
    for (var e in stream) {
      var s = e.asBroadcastStream().listen((event) => notifyListeners());

      subcriptions.add(s);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    for (var e in subcriptions) {
      e.cancel();
    }
    super.dispose();
  }
}
