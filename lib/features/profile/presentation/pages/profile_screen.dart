import 'package:chat_app/features/login/presentation/bloc/sign_in_bloc.dart';
import 'package:chat_app/router/route_name.dart';
import 'package:chat_app/theme/bloc/theme_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/menu_list.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xff152033),
                    // backgroundImage: NetworkImage('https://feji.us/m5az7q'),
                  ),
                  title: Text(
                    "Demo Name",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    "Demo Email",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        // _showbar(context);
                        context.read<SignInBloc>().add(SignOutRequired());
                      },
                      icon: const Icon(
                        FontAwesomeIcons.rightFromBracket,
                        size: 30,
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                const MenuList(
                  leadingIcon: Icons.person,
                  trailingWidgets: Icon(CupertinoIcons.right_chevron),
                  title: "Accounts",
                ),
                const MenuList(
                  leadingIcon: Icons.message,
                  title: "Chats",
                  trailingWidgets: Icon(CupertinoIcons.right_chevron),
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocBuilder<ThemeBloc, ThemeState>(
                    bloc: ThemeBloc(),
                    builder: (context, state) {
                      return MenuList(
                        leadingIcon: state.themeType == ThemeType.dark
                            ? Icons.dark_mode
                            : state.themeType == ThemeType.light
                                ? Icons.light_mode
                                : Icons.bookmark_outline,
                        title:
                            "Appereane - ${state.themeType == ThemeType.dark ? "Dark" : state.themeType == ThemeType.light ? "Light" : "System"}",
                        trailingWidgets:
                            PopupMenuButton(itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                                value: 'Light',
                                onTap: () => BlocProvider.of<ThemeBloc>(context)
                                    .add(const ThemeModeChanged(
                                        themeMode: 'light')),
                                child: MenuList(
                                  title: 'Light',
                                  trailingWidgets: Visibility(
                                      visible:
                                          state.themeType == ThemeType.light,
                                      child: const Icon(Icons.check)),
                                )),
                            PopupMenuItem(
                                onTap: () {
                                  context
                                      .read<ThemeBloc>()
                                      .add(ThemeModeChanged(themeMode: 'dark'));
                                },
                                value: 'Dark',
                                child: MenuList(
                                  title: 'Dark',
                                  trailingWidgets: Visibility(
                                      visible:
                                          state.themeType == ThemeType.dark,
                                      child: const Icon(Icons.check)),
                                )),
                            PopupMenuItem(
                                onTap: () => BlocProvider.of<ThemeBloc>(context)
                                    .add(const ThemeModeChanged(
                                        themeMode: 'system')),
                                value: 'System',
                                child: MenuList(
                                  title: 'System',
                                  trailingWidgets: Visibility(
                                      visible:
                                          state.themeType == ThemeType.system,
                                      child: const Icon(Icons.check)),
                                ))
                          ];
                        }),
                      );
                    }),
                const MenuList(
                  leadingIcon: Icons.notifications,
                  title: "Notification",
                  trailingWidgets: Icon(CupertinoIcons.right_chevron),
                ),
                const MenuList(
                  leadingIcon: Icons.privacy_tip_outlined,
                  title: "Privacy",
                  trailingWidgets: Icon(CupertinoIcons.right_chevron),
                ),
                const MenuList(
                  leadingIcon: FontAwesomeIcons.file,
                  title: "Data Usage",
                  trailingWidgets: Icon(CupertinoIcons.right_chevron),
                ),
                const SizedBox(
                  height: 30,
                ),
                const MenuList(
                  leadingIcon: Icons.question_mark_rounded,
                  title: "Help",
                  trailingWidgets: Icon(CupertinoIcons.right_chevron),
                ),
                const MenuList(
                  leadingIcon: Icons.messenger_outline_outlined,
                  title: "Invite Your Friends",
                  trailingWidgets: Icon(CupertinoIcons.right_chevron),
                ),
              ],
            ),
          );
        },
      )),
    );
  }

// void _showbar(BuildContext context) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return Container(
//           width: 300,
//           height: 200,
//           decoration:
//               BoxDecoration(color: Theme.of(context).colorScheme.secondary),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text("Do you want log out?"),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ElevatedButton(
//                         onPressed: () {}, child: const Text("Yes")),
//                     ElevatedButton(onPressed: () {}, child: const Text("No")),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         );
//       });
// }
}
