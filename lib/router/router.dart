import 'package:chat_app/features/splash/presentation/bloc/authentication_bloc.dart';
import 'package:chat_app/router/route_name.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/bottom_nav_bar/presentation/bottom_nav_bar.dart';
import '../features/chats/presentation/pages/chat_screen.dart';
import '../features/contacts/presentation/pages/contact_screen.dart';
import '../features/login/presentation/pages/login_screen.dart';
import '../features/profile/presentation/pages/profile_screen.dart';
import '../features/signup/presentation/pages/signup_screen.dart';
import '../features/splash/presentation/page/splash_screen.dart';

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
      // redirect: (context, state) {
      //   context.read<AuthenticationBloc>().add(AuthenticationUserChanged());
      //   if (context.watch<AuthenticationBloc>().state.status ==
      //       AuthenticateStatus.authenticate) {
      //     return RouteName.bottomNavBarScreen;
      //   } else {
      //     return RouteName.logInScreen;
      //   }
      // },
      routes: [
        //splash screen

        GoRoute(
          path: RouteName.initial,
          name: RouteName.initial,
          pageBuilder: (context, state) {
            return const MaterialPage(child: SplashScreen());
          },
        ),

        //sign in screen
        GoRoute(
          path: RouteName.signInScreen,
          name: RouteName.signInScreen,
          pageBuilder: (context, state) {
            return const MaterialPage(child: SignInScreen());
          },
        ),
        //sign up screen
        GoRoute(
          path: RouteName.logInScreen,
          name: RouteName.logInScreen,
          pageBuilder: (context, state) {
            return const MaterialPage(child: LogInScreen());
          },
        ),

        //bottom nav bar screen
        GoRoute(
          path: RouteName.bottomNavBarScreen,
          name: RouteName.bottomNavBarScreen,
          pageBuilder: (context, state) {
            return const MaterialPage(child: BottomNavBar());
          },
        ),

        //chat screen
        GoRoute(
          path: RouteName.chatScreen,
          name: RouteName.chatScreen,
          pageBuilder: (context, state) {
            return const MaterialPage(child: ChatScreen());
          },
        ),
        //contact screen
        GoRoute(
          path: RouteName.contactScreen,
          name: RouteName.contactScreen,
          pageBuilder: (context, state) {
            return MaterialPage(child: ContactScreen());
          },
        ),

        //profile screen
        GoRoute(
          path: RouteName.profileScreen,
          name: RouteName.profileScreen,
          pageBuilder: (context, state) {
            return const MaterialPage(child: ProfileScreen());
          },
        ),

        //message screen
        // GoRoute(
        //   path: RouteName.conversationScreen,
        //   name: RouteName.conversationScreen,
        //   pageBuilder: (context, state) {
        //     MyUser myuser = MyUser.empty;
        //     return const MaterialPage(
        //         child: ConversationScreen(myuser: myuser));
        //   },
        // ),
      ]);
}
