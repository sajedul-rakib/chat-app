import 'package:chat_app/features/chats/presentation/bloc/online_user_bloc/online_user_bloc.dart';
import 'package:chat_app/features/login/presentation/bloc/sign_in_bloc.dart';
import 'package:chat_app/features/profile/presentation/widgets/theme_mode_list_tile.dart';
import 'package:chat_app/features/profile/presentation/widgets/user_detail_list_tile.dart';
import 'package:chat_app/features/splash/presentation/widgets/app_button.dart';
import 'package:chat_app/features/widgets/custom_snackbar.dart';
import 'package:chat_app/router/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../shared/shared.dart';
import '../widgets/menu_list.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "More",
        ),
      ),
      body: SafeArea(
          child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignOutSuccess) {
            Navigator.pushNamedAndRemoveUntil(context, RouteName.logInScreen,
                ModalRoute.withName(RouteName.logInScreen));
            CustomSnackbar.show(context: context, message: "Log out!");
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    UserDetailListTile(),
                    const SizedBox(
                      height: 30,
                    ),
                    const MenuList(
                      leadingWidget: Icon(Icons.person),
                      trailingWidgets: Icon(CupertinoIcons.right_chevron),
                      title: "Accounts",
                    ),
                    MenuList(
                      leadingWidget: Icon(Icons.person_add_alt),
                      trailingWidgets: Icon(CupertinoIcons.right_chevron),
                      title: "Add Friend",
                      onPressed: () {
                        Navigator.pushNamed(context, RouteName.addFriend);
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ThemeModeListTile(),
                    const MenuList(
                      leadingWidget: Icon(Icons.notifications),
                      title: "Notification",
                      trailingWidgets: Icon(CupertinoIcons.right_chevron),
                    ),
                    const MenuList(
                      leadingWidget: Icon(Icons.privacy_tip_outlined),
                      title: "Privacy",
                      trailingWidgets: Icon(CupertinoIcons.right_chevron),
                    ),
                    const MenuList(
                      leadingWidget: Icon(FontAwesomeIcons.file),
                      title: "Data Usage",
                      trailingWidgets: Icon(CupertinoIcons.right_chevron),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const MenuList(
                      leadingWidget: Icon(Icons.question_mark_rounded),
                      title: "Help",
                      trailingWidgets: Icon(CupertinoIcons.right_chevron),
                    ),
                    const MenuList(
                      leadingWidget: Icon(Icons.messenger_outline_outlined),
                      title: "Invite Your Friends",
                      trailingWidgets: Icon(CupertinoIcons.right_chevron),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 300,
                  child: AppButton(
                    buttonTitle: "Log out",
                    iconData: Icons.logout,
                    backgroundColor: Colors.red,
                    onPressed: () {
                      context.read<SignInBloc>().add(SignOutRequired());
                      final onlineUserBloc = context.read<OnlineUserBloc>();
                      onlineUserBloc.socket
                          ?.emit("user_offline", {"userId": SharedData.userId});
                      onlineUserBloc.socket?.disconnect();
                    },
                  ),
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
