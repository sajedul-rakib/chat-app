import 'dart:developer';

import 'package:chat_app/features/chats/presentation/bloc/bloc/get_friend_list_bloc.dart';
import 'package:chat_app/features/contacts/presentation/widgets/add_friend_dialog.dart';
import 'package:chat_app/features/signup/presentation/widget/text_form_field.dart';
import 'package:chat_app/features/splash/presentation/bloc/authentication_bloc.dart';
import 'package:chat_app/features/splash/presentation/widgets/app_button.dart';
import 'package:chat_app/features/widgets/circular_progress_indicator.dart';
import 'package:chat_app/features/widgets/custom_snackbar.dart';
import 'package:chat_app/router/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../contacts/presentation/widgets/friend_list_tile.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _friendGmailETController;
  @override
  void initState() {
    context.read<GetFriendListBloc>().add(GetFriendListRequested(
        subscriberId: context.read<AuthenticationBloc>().state.user!.uid));
    _friendGmailETController = TextEditingController();
    super.initState();
  }

  //dispose
  @override
  void dispose() {
    //dispose the controller
    _friendGmailETController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          InkWell(
              onTap: () {
                CustomSnackbar.show(
                    context: context, message: "Update will latter");
              },
              child: Icon(CupertinoIcons.list_bullet)),
          SizedBox(
            width: 20,
          ),
          InkWell(
              onTap: () => CustomSnackbar.show(
                  context: context, message: "Update will latter"),
              child: Icon(FontAwesomeIcons.message)),
          SizedBox(
            width: 30,
          )
        ],
        title: const Text(
          "Chats",
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => CustomSnackbar.show(
                              context: context, message: "Update will latter"),
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 2,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                )),
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.plus,
                                size: 30,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Your Story",
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    // ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     shrinkWrap: true,
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     itemCount: 4,
                    //     itemBuilder: (_, index) {
                    //       return Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           Container(
                    //             margin: const EdgeInsets.only(left: 10),
                    //             width: 75,
                    //             height: 75,
                    //             decoration: BoxDecoration(
                    //                 shape: BoxShape.rectangle,
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 border: Border.all(
                    //                   width: 2,
                    //                   color: Theme.of(context)
                    //                       .colorScheme
                    //                       .onSecondary,
                    //                 )),
                    //             child: Center(
                    //               child: Icon(
                    //                 FontAwesomeIcons.plus,
                    //                 size: 30,
                    //                 color: Theme.of(context)
                    //                     .colorScheme
                    //                     .onSecondary,
                    //               ),
                    //             ),
                    //           ),
                    //           Text(
                    //             "Your Story",
                    //             style: TextStyle(
                    //                 fontSize: 14,
                    //                 color:
                    //                     Theme.of(context).colorScheme.onPrimary,
                    //                 fontWeight: FontWeight.w400),
                    //           )
                    //         ],
                    //       );
                    //     }),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              InputFormField(
                hintText: 'Placeholder',
                prefix: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 15,
                  ),
                ),
                onChange: (value) {
                  log(value);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<GetFriendListBloc, GetFriendListState>(
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    return const Center(
                      child: CustomCircularProgressIndicator(),
                    );
                  } else {
                    return state.friendList != null &&
                            state.friendList!.isNotEmpty
                        ? ListView.separated(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.friendList!.length,
                            itemBuilder: (_, index) {
                              return FriendListTile(
                                fullName: state.friendList![index].fullname,
                                imageUrl: state.friendList![index].profilePic,
                                onPressed: () => Navigator.pushNamed(
                                    context, RouteName.conversationScreen,
                                    arguments: state.friendList![index]),
                              );
                            },
                            separatorBuilder: (_, int index) {
                              return const Divider();
                            },
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 20,
                            children: [
                              Text("No friends found",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontSize: 20)),
                              SizedBox(
                                width: 180,
                                child: AppButton(
                                    buttonTitle: "Add Friend",
                                    onPressed: () {
                                      addFriendDialog(
                                          context, _friendGmailETController);
                                    }),
                              )
                            ],
                          );
                  }
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
