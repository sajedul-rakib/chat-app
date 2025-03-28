import 'package:chat_app/features/chats/data/repositories/chat_repositories.dart';
import 'package:chat_app/features/conversation/datasource/repositories/message_repositories.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:chat_app/simple_bloc_observer.dart';
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
 await dotenv.load(fileName: ".env");
 await SharedData.init();
 bool checkIsFirstOpen=await SharedData.checkIsFirstOpen();
 SharedData.setIsFirstOpen();
  runApp(MainApp(
    signupRepo: SignupRepo(),
    loginRepo: LoginRepo(),
    chatRepo: ChatRepositories(),
    messageRepositories: MessageRepositories(),
    checkIsFirstOpen:checkIsFirstOpen
  ));
}
