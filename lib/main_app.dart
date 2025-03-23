import 'dart:developer';

import 'package:chat_app/features/bottom_nav_bar/presentation/bottom_nav_bar.dart';
import 'package:chat_app/features/chats/domain/repositories/user_repo.dart';
import 'package:chat_app/features/chats/presentation/bloc/bloc/get_friend_list_bloc.dart';
import 'package:chat_app/features/conversation/presentation/pages/conversation_screen.dart';
import 'package:chat_app/features/login/presentation/pages/login_screen.dart';
import 'package:chat_app/features/signup/data/models/user.dart';
import 'package:chat_app/features/signup/presentation/pages/signup_screen.dart';
import 'package:chat_app/features/splash/presentation/bloc/authentication_bloc.dart';
import 'package:chat_app/router/route_name.dart';
import 'package:chat_app/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/login/domain/repositories/login_repo.dart';
import 'features/login/presentation/bloc/sign_in_bloc.dart';
import 'features/signup/domain/repositories/signup_repo.dart';
import 'features/signup/presentation/bloc/sign_up_bloc.dart';
import 'theme/app_theme.dart';

class MainApp extends StatelessWidget {
  const MainApp(
      {super.key,
      required SignupRepo signupRepo,
      required LoginRepo loginRepo,
      required ThemeMode themeMode,
      required ChatRepo chatRepo})
      : _signupRepo = signupRepo,
        _loginRepo = loginRepo,
        _chatRepo = chatRepo;

  final SignupRepo _signupRepo;
  final LoginRepo _loginRepo;
  final ChatRepo _chatRepo;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SignInBloc>(
          create: (_) => SignInBloc(loginRepo: _loginRepo),
        ),
        RepositoryProvider<SignUpBloc>(
            create: (_) => SignUpBloc(signUpRepo: _signupRepo)),
        RepositoryProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(loginRepo: _loginRepo)),
        RepositoryProvider<GetFriendListBloc>(
            create: (_) => GetFriendListBloc(chatRepo: _chatRepo))
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        bloc: ThemeBloc(),
        builder: (BuildContext context, state) {
          log('from main app ${state.themeType}');
          return MaterialApp(
            themeMode: state.themeType == ThemeType.light
                ? ThemeMode.light
                : ThemeMode.dark,
            darkTheme: AppTheme.darkTheme(context),
            theme: AppTheme.lightTheme(context),
            debugShowCheckedModeBanner: false,
            // routerConfig: AppRouter.router,
            routes: {
              // RouteName.initial: (BuildContext context) => SplashScreen(),
              RouteName.logInScreen: (BuildContext context) => LogInScreen(),
              RouteName.bottomNavBarScreen: (BuildContext context) =>
                  BottomNavBar(),
              RouteName.signInScreen: (BuildContext context) => SigninScreen(),
              RouteName.conversationScreen: (BuildContext context) {
                final MyUser myuser =
                    ModalRoute.of(context)!.settings.arguments as MyUser;

                return ConversationScreen(
                  myuser: myuser,
                );
              },
            },
            initialRoute: RouteName.initial,
            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                bloc: AuthenticationBloc(loginRepo: _loginRepo)
                  ..add(AuthenticationUserChanged()),
                builder: (context, state) {
                  if (state.status == AuthenticateStatus.authenticate) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider<ThemeBloc>(
                          create: (_) => ThemeBloc(),
                        ),
                        BlocProvider<GetFriendListBloc>(
                            create: (_) =>
                                GetFriendListBloc(chatRepo: _chatRepo)),
                      ],
                      child: BottomNavBar(),
                    );
                  } else {
                    return LogInScreen();
                  }
                }),
            title: "Chateo",
          );
        },
      ),
    );
  }
}
