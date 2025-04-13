import 'dart:io';

import 'package:chat_app/features/chats/data/repositories/chat_repositories.dart';
import 'package:chat_app/features/conversation/datasource/repositories/message_repositories.dart';
import 'package:chat_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:chat_app/services/notification/local_notification.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:chat_app/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'features/login/domain/repositories/login_repo.dart';
import 'features/signup/domain/repositories/signup_repo.dart';
import 'main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //bloc observer
  Bloc.observer = SimpleBlocObserver();
  //Initialize preferences

  // load the env file which contain various data
  await Firebase.initializeApp();
  if(!Platform.isIOS) {
    await FlutterNotification.instance.initialize();
  }
  await dotenv.load(fileName: ".env");
  await SharedData.init();
  runApp(MainApp(
    signupRepo: SignupRepo(),
    loginRepo: LoginRepo(),
    chatRepo: ChatRepositories(),
    profileRepo: ProfileRepository(),
    messageRepositories: MessageRepositories(),
  ));
}
