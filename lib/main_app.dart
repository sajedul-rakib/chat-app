import 'package:chat_app/features/bottom_nav_bar/presentation/bottom_nav_bar.dart';
import 'package:chat_app/features/chats/data/models/user.dart';
import 'package:chat_app/features/chats/domain/repositories/chat_repo.dart';
import 'package:chat_app/features/chats/presentation/bloc/bloc/get_friend_list_bloc.dart';
import 'package:chat_app/features/conversation/datasource/repositories/message_repositories.dart';
import 'package:chat_app/features/conversation/presentation/bloc/message_bloc.dart';
import 'package:chat_app/features/conversation/presentation/pages/conversation_screen.dart';
import 'package:chat_app/features/login/presentation/pages/login_screen.dart';
import 'package:chat_app/features/signup/data/models/user.dart';
import 'package:chat_app/features/signup/presentation/pages/signup_screen.dart';
import 'package:chat_app/features/splash/presentation/bloc/authentication_bloc.dart';
import 'package:chat_app/features/splash/presentation/page/splash_screen.dart';
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
      required ChatRepo chatRepo,
      required MessageRepositories messageRepositories,
      required bool checkIsFirstOpen})
      : _signupRepo = signupRepo,
        _loginRepo = loginRepo,
        _chatRepo = chatRepo,
        _messageRepositories = messageRepositories,
        _checkIsFirstOpen = checkIsFirstOpen;

  final SignupRepo _signupRepo;
  final LoginRepo _loginRepo;
  final ChatRepo _chatRepo;
  final MessageRepositories _messageRepositories;
  final bool _checkIsFirstOpen;

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
            create: (_) => GetFriendListBloc(chatRepo: _chatRepo)),
        RepositoryProvider<MessageBloc>(
            create: (_) =>
                MessageBloc(messageRepositories: _messageRepositories))
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        bloc: ThemeBloc(),
        builder: (BuildContext context, state) {
          return MaterialApp(
            // themeMode: state.themeType == ThemeType.light
            //     ? ThemeMode.light
            //     : ThemeMode.dark,
            themeMode: ThemeMode.dark,
            darkTheme: AppTheme.darkTheme(context),
            theme: AppTheme.lightTheme(context),
            debugShowCheckedModeBanner: false,
            routes: {
              // RouteName.initial: (BuildContext context) => SplashScreen(),
              RouteName.logInScreen: (BuildContext context) => LogInScreen(),
              RouteName.bottomNavBarScreen: (BuildContext context) =>
                  BottomNavBar(),
              RouteName.signInScreen: (BuildContext context) => SignInScreen(),
              RouteName.conversationScreen: (BuildContext context) {
                final Map<String, dynamic> args = ModalRoute.of(context)!
                    .settings
                    .arguments as Map<String, dynamic>;

                return ConversationScreen(
                  friendUser: args['user'] as User,
                  conversationId: args['conversationId'],
                  loggedUserId: args['loggedUserId'],
                );
              },
            },
            initialRoute: RouteName.initial,
            home: _checkIsFirstOpen
                ? SplashScreen()
                : BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    bloc: AuthenticationBloc(loginRepo: _loginRepo)
                      ..add(AuthenticationUserChanged()),
                    builder: (context, state) {
                      if (state.status == AuthenticateStatus.authenticate) {
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider<ThemeBloc>(
                              create: (_) => ThemeBloc(),
                            ),
                            BlocProvider<AuthenticationBloc>(
                                create: (_) =>
                                    AuthenticationBloc(loginRepo: _loginRepo)),
                            BlocProvider<GetFriendListBloc>(
                                create: (_) =>
                                    GetFriendListBloc(chatRepo: _chatRepo)),
                            BlocProvider<MessageBloc>(
                                create: (_) => MessageBloc(
                                    messageRepositories: _messageRepositories)),
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
