import 'dart:developer';

import 'package:chat_app/features/chats/presentation/bloc/bloc/get_friend_list_bloc.dart';
import 'package:chat_app/features/conversation/datasource/repositories/socket_repository.dart';
import 'package:chat_app/features/signup/presentation/widget/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../search_user_bloc/search_user_bloc.dart';
import '../widgets/friend_list_ui.dart';
import '../widgets/story_section.dart';
import '../widgets/user_search_result.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  late TextEditingController _friendGmailETController;
  late bool _openSearchInput;
  late bool _openSearchBox;
  late SocketRepository _socketRepository;

  @override
  void initState() {
    context.read<GetFriendListBloc>().add(GetFriendListRequested());

    WidgetsBinding.instance.addObserver(this);
    _socketRepository = SocketRepository();
    _socketRepository.connect();
    _openSearchBox = true;
    _openSearchInput = false;
    _friendGmailETController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _socketRepository.connect();
    }
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _socketRepository.disconnect();
    }
    super.didChangeAppLifecycleState(state);
  }

  //dispose
  @override
  void dispose() {
    _socketRepository.disconnect();
    WidgetsBinding.instance.removeObserver(this);
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
      appBar: buildChatAppBar(context),
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
                  //story section
                  StorySection(),
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
                  FriendListUi(
                      friendGmailETController: _friendGmailETController)
                ],
              ),
            ),
          ),
          //search result
          if (_openSearchBox)
            UserSearchResult(
              textEditingController: _friendGmailETController,
            )
        ],
      )),
    );
  }

  AppBar buildChatAppBar(BuildContext context) {
    return AppBar(
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
                    context
                        .read<SearchUserBloc>()
                        .add(SearchFriendRequestRequired(keyword: v));
                  }
                },
              )
            : const Text(
                "Chats",
              ));
  }
}
