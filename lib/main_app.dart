import 'package:chat_app/features/login/data/repositories/login_repository.dart';
import 'package:chat_app/features/signup/data/repositories/signup_repository.dart';
import 'package:chat_app/services/locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/theme/app_theme.dart';
import 'package:chat_app/theme/bloc/theme_bloc.dart';
import 'package:chat_app/features/splash/presentation/bloc/authentication_bloc.dart';
import 'package:chat_app/features/login/presentation/bloc/sign_in_bloc.dart';
import 'package:chat_app/features/signup/presentation/bloc/sign_up_bloc.dart';
import 'package:chat_app/features/conversation/presentation/bloc/message_bloc.dart';
import 'package:chat_app/features/conversation/presentation/send_bloc/send_bloc.dart';
import 'package:chat_app/features/chats/domain/repositories/chat_repo.dart';
import 'package:chat_app/features/add_friend/presentation/bloc/search_user_bloc/search_user_bloc.dart';
import 'package:chat_app/features/add_friend/presentation/bloc/add_user_bloc/add_user_bloc.dart';
import 'package:chat_app/features/profile/data/repositories/profile_repo.dart';
import 'package:chat_app/router/route_name.dart';
import 'package:chat_app/features/login/presentation/pages/login_screen.dart';
import 'package:chat_app/features/signup/presentation/pages/signup_screen.dart';
import 'package:chat_app/features/splash/presentation/page/splash_screen.dart';
import 'package:chat_app/features/chats/data/models/user.dart';
import 'package:chat_app/features/chats/presentation/bloc/get_user_bloc/get_friend_list_bloc.dart';
import 'package:chat_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:chat_app/features/conversation/presentation/pages/conversation_screen.dart';
import 'package:chat_app/features/bottom_nav_bar/presentation/bottom_nav_bar.dart';
import 'package:chat_app/features/add_friend/presentation/page/add_friend.dart';
import 'package:chat_app/features/chats/presentation/bloc/online_user_bloc/online_user_bloc.dart';

import 'features/conversation/domain/repositories/message_repo.dart';

class MainApp extends StatelessWidget {
  MainApp({
    super.key,
  });

  final SignupRepo signupRepo = getIt<SignupRepo>();
  final LogInRepo loginRepo = getIt<LogInRepo>();
  final ChatRepo chatRepo = getIt<ChatRepo>();
  final ProfileRepo profileRepo = getIt<ProfileRepo>();
  final MessageRepo messageRepositories = getIt<MessageRepo>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /// Global Blocs (not user dependent)
        BlocProvider(create: (_) => ThemeBloc()..add(InitialTheme())),
        BlocProvider(
            create: (_) => AuthenticationBloc(loginRepo: loginRepo)
              ..add(CheckUserLoggedIn())),
        BlocProvider(create: (_) => SignInBloc(loginRepo: loginRepo)),
        BlocProvider(create: (_) => SignUpBloc(signUpRepo: signupRepo)),
        BlocProvider(
            create: (_) =>
                MessageBloc(messageRepositories: messageRepositories)),
        BlocProvider(
            create: (_) => SendBloc(messageRepositories: messageRepositories)),
        BlocProvider(create: (_) => SearchUserBloc(chatRepo: chatRepo)),
        BlocProvider(create: (_) => AddUserBloc(chatRepo: chatRepo)),
        BlocProvider(create: (_) => OnlineUserBloc()),
        BlocProvider(
          create: (_) => GetFriendListBloc(chatRepo: chatRepo),
        ),
        BlocProvider(
          create: (_) => ProfileBloc(profileRepo: profileRepo),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: "Chateo",
            debugShowCheckedModeBanner: false,
            themeMode: themeState.themeType == ThemeType.light
                ? ThemeMode.light
                : themeState.themeType == ThemeType.dark
                    ? ThemeMode.dark
                    : ThemeMode.system,
            theme: AppTheme.lightTheme(context),
            darkTheme: AppTheme.darkTheme(context),
            routes: {
              RouteName.bottomNavBarScreen: (context) => const BottomNavBar(),
              RouteName.logInScreen: (context) => const LogInScreen(),
              RouteName.signInScreen: (context) => const SignInScreen(),
              RouteName.addFriend: (context) => const AddFriend(),
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
            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, authState) {
                if (authState.status == AuthenticateStatus.authenticate) {
                  return const BottomNavBar();
                } else if (authState.status ==
                    AuthenticateStatus.unAuthenticate) {
                  return const LogInScreen();
                } else {
                  return const SplashScreen(); // Waiting for auth check
                }
              },
            ),
          );
        },
      ),
    );
  }
}
