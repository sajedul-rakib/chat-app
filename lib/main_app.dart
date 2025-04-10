
import 'package:chat_app/features/bottom_nav_bar/presentation/bottom_nav_bar.dart';
import 'package:chat_app/features/chats/data/models/user.dart';
import 'package:chat_app/features/chats/domain/repositories/chat_repo.dart';
import 'package:chat_app/features/chats/presentation/add_user_bloc/add_user_bloc.dart';
import 'package:chat_app/features/chats/presentation/bloc/bloc/get_friend_list_bloc.dart';
import 'package:chat_app/features/chats/presentation/search_user_bloc/search_user_bloc.dart';
import 'package:chat_app/features/conversation/datasource/repositories/message_repositories.dart';
import 'package:chat_app/features/conversation/presentation/bloc/message_bloc.dart';
import 'package:chat_app/features/conversation/presentation/pages/conversation_screen.dart';
import 'package:chat_app/features/conversation/presentation/send_bloc/send_bloc.dart';
import 'package:chat_app/features/login/presentation/pages/login_screen.dart';
import 'package:chat_app/features/profile/data/repositories/profile_repo.dart';
import 'package:chat_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:chat_app/features/signup/presentation/pages/signup_screen.dart';
import 'package:chat_app/features/splash/presentation/bloc/authentication_bloc.dart';
import 'package:chat_app/features/splash/presentation/page/splash_screen.dart';
import 'package:chat_app/router/route_name.dart';
import 'package:chat_app/services/notification/local_notification.dart';
import 'package:chat_app/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/login/domain/repositories/login_repo.dart';
import 'features/login/presentation/bloc/sign_in_bloc.dart';
import 'features/signup/domain/repositories/signup_repo.dart';
import 'features/signup/presentation/bloc/sign_up_bloc.dart';
import 'theme/app_theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required SignupRepo signupRepo,
    required LoginRepo loginRepo,
    required ChatRepo chatRepo,
    required ProfileRepo profileRepo,
    required MessageRepositories messageRepositories,
    required bool checkIsFirstOpen,
  })  : _signupRepo = signupRepo,
        _loginRepo = loginRepo,
        _chatRepo = chatRepo,
        _profileRepo = profileRepo,
        _messageRepositories = messageRepositories,
        _checkIsFirstOpen = checkIsFirstOpen;

  final SignupRepo _signupRepo;
  final LoginRepo _loginRepo;
  final ChatRepo _chatRepo;
  final ProfileRepo _profileRepo;
  final MessageRepositories _messageRepositories;
  final bool _checkIsFirstOpen;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SignInBloc(loginRepo: _loginRepo)),
        BlocProvider(create: (_) => SignUpBloc(signUpRepo: _signupRepo)),
        BlocProvider(
            create: (_) => AuthenticationBloc(loginRepo: _loginRepo)
              ..add(AuthenticationUserChanged())),
        BlocProvider(create: (_) => GetFriendListBloc(chatRepo: _chatRepo)),
        BlocProvider(
            create: (_) =>
                MessageBloc(messageRepositories: _messageRepositories)),
        BlocProvider(
            create: (_) => SendBloc(messageRepositories: _messageRepositories)),
        BlocProvider(create: (_) => SearchUserBloc(chatRepo: _chatRepo)),
        BlocProvider(create: (_) => AddUserBloc(chatRepo: _chatRepo)),
        BlocProvider(create: (_) => ProfileBloc(profileRepo: _profileRepo)),
        BlocProvider(create: (_) => ThemeBloc()..add(InitialTheme())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            themeMode: state.themeType == ThemeType.light
                ? ThemeMode.light
                : state.themeType == ThemeType.dark
                    ? ThemeMode.dark
                    : ThemeMode.system,
            darkTheme: AppTheme.darkTheme(context),
            theme: AppTheme.lightTheme(context),
            debugShowCheckedModeBanner: false,
            routes: {
              RouteName.logInScreen: (context) => LogInScreen(),
              RouteName.bottomNavBarScreen: (context) => BottomNavBar(),
              RouteName.signInScreen: (context) => SignInScreen(),
              RouteName.conversationScreen: (context) {
                final args = ModalRoute.of(context)!.settings.arguments
                    as Map<String, dynamic>;
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
                    builder: (context, state) {
                      if (state.status == AuthenticateStatus.authenticate) {
                        return BottomNavBar();
                      } else {
                        return LogInScreen();
                      }
                    },
                  ),
            title: "Chateo",
          );
        },
      ),
    );
  }
}
