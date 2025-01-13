import 'package:chat_app/features/chats/data/repositories/user_repositories.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:chat_app/shared/theme_shared.dart';
import 'package:chat_app/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/login/domain/repositories/login_repo.dart';
import 'features/signup/domain/repositories/signup_repo.dart';
import 'main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();
  await SharedData.checkIsFirstOpen();
  String? theme = await ThemeShared.getTheme();
  ThemeMode? themeMode;
  if (theme != null) {
    if (theme == 'light') {
      themeMode = ThemeMode.light;
    } else if (theme == 'dark') {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.system;
    }
  } else {
    themeMode = ThemeMode.system;
  }
  runApp(MainApp(
    signupRepo: SignupRepo(),
    loginRepo: LoginRepo(),
    userRepo: UserRepositories(),
    themeMode: themeMode,
  ));
}
