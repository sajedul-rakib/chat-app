import 'dart:developer';

import 'package:chat_app/core/constants/colors/app_colors.dart';
import 'package:chat_app/features/chats/presentation/bloc/bloc/get_friend_list_bloc.dart';
import 'package:chat_app/features/contacts/presentation/widgets/add_friend_dialog.dart';
import 'package:chat_app/features/signup/presentation/widget/text_form_field.dart';
import 'package:chat_app/features/splash/presentation/widgets/app_button.dart';
import 'package:chat_app/features/widgets/circular_progress_indicator.dart';
import 'package:chat_app/features/widgets/custom_snackbar.dart';
import 'package:chat_app/router/route_name.dart';
import 'package:chat_app/shared/shared.dart';
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
  late bool _openSearchInput;
  late bool _openSearchBox;

  String token = SharedData.token ?? '';

  @override
  void initState() {
    if (token.isNotEmpty) {
      context
          .read<GetFriendListBloc>()
          .add(GetFriendListRequested(token: token));
    }
    _openSearchBox = true;
    _openSearchInput = false;
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

  void _closeSearchBox() {
    Future.delayed(Duration(seconds: 5)).then((v) {
      if (_friendGmailETController.text.isEmpty) {
        setState(() {
          _openSearchInput = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: _openSearchInput,
          elevation: 0,
          actions: [
            if (!_openSearchInput)
              InkWell(
                onTap: () {
                  if (!_openSearchInput) {
                    setState(() {
                      _openSearchInput = true;
                    });
                    _closeSearchBox();
                  } else {
                    setState(() {
                      _openSearchInput = false;
                    });
                  }
                },
                child: Icon(
                  CupertinoIcons.plus,
                  size: 30,
                ),
              ),
            const SizedBox(
              width: 30,
            )
          ],
          title: _openSearchInput
              ? InputFormField(
                  hintText: "Search friend with name or email",
                  textEditionController: _friendGmailETController,
                  onChange: (v) {
                    if (v.isEmpty) {
                      setState(() {
                        _openSearchInput = false;
                        _openSearchBox = false;
                      });
                    } else {
                      setState(() {
                        _openSearchBox = true;
                      });
                      context.read<GetFriendListBloc>().add(
                          SearchFriendRequestRequired(
                              token: token, keyword: v));
                    }
                  },
                )
              : const Text(
                  "Chats",
                )),
      body: SafeArea(
          child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
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
                                  context: context,
                                  message: "Update will latter"),
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 2,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    )),
                                child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.plus,
                                    size: 30,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "Your Story",
                              style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
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
                    if (state is GetFriendListSuccess) {
                      return state.friendList.isNotEmpty
                          ? ListView.separated(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.friendList.length,
                              itemBuilder: (_, index) {
                                if (state.userId ==
                                    state.friendList[index].owner!.sId) {
                                  return FriendListTile(
                                    user: state.friendList[index].participant!,
                                    onPressed: () => Navigator.pushNamed(
                                        context, RouteName.conversationScreen,
                                        arguments: {
                                          'user': state
                                              .friendList[index].participant,
                                          'conversationId':
                                              state.friendList[index].sId,
                                          'loggedUserId':
                                              state.friendList[index].owner?.sId
                                        }),
                                  );
                                } else {
                                  return FriendListTile(
                                    user: state.friendList[index].owner!,
                                    onPressed: () => Navigator.pushNamed(
                                        context, RouteName.conversationScreen,
                                        arguments: {
                                          'user': state.friendList[index].owner,
                                          'conversationId':
                                              state.friendList[index].sId,
                                          'loggedUserId': state
                                              .friendList[index]
                                              .participant
                                              ?.sId
                                        }),
                                  );
                                }
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
                    if (state is GetFriendListLoading) {
                      return Center(
                        child: CustomCircularProgressIndicator(),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  })
                ],
              ),
            ),
          ),
          //search result
          if (_openSearchBox)
            Container(
                decoration: BoxDecoration(
                    color:
                        AppColors.secondaryDarkBackground.withValues(alpha: 2)),
                child: BlocBuilder<GetFriendListBloc, GetFriendListState>(
                    builder: (context, state) {
                  if (state is SearchFriendLoading) {
                    Center(
                      child: CustomCircularProgressIndicator(),
                    );
                  }
                  if (state is SearchFriendSuccess) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: ListView.builder(
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Row(
                                              spacing: 10,
                                              children: [
                                                CircleAvatar(
                                                  child: Icon(Icons.person),
                                                ),
                                                Text(
                                                  "Sajedul Islam Rakib",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child:
                                                AppButton(buttonTitle: "Add")),
                                      ],
                                    ),
                                  );
                                }))
                      ],
                    );
                  }
                  if (state is SearchFriendFailure) {
                    return Text(state.errMsg.toString());
                  }
                  return SizedBox.shrink();
                }))
        ],
      )),
    );
  }
}
