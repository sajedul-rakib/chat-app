import 'dart:io';

import 'package:chat_app/services/locator/service_locator.dart';
import 'package:chat_app/services/notification/local_notification.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:chat_app/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


import 'main_app.dart';

void main() async {
  // initialize the service locator
  setupServiceLocator();
  WidgetsFlutterBinding.ensureInitialized();
  //bloc observer
  Bloc.observer = SimpleBlocObserver();
  //Initialize preferences

  // load the env file which contain various data
  await Firebase.initializeApp();
  if (!Platform.isIOS) {
    await FlutterNotification.instance.initialize();
  }
  await dotenv.load(fileName: ".env");
  await SharedData.init();
  runApp(MainApp());
}
