import 'dart:developer';
import 'package:chat_app/features/signup/presentation/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../bloc/get_user_bloc/get_friend_list_bloc.dart';
import '../widgets/friend_list_ui.dart';
import '../widgets/story_section.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _friendGmailETController;

  @override
  void initState() {
    context.read<GetFriendListBloc>().add(GetFriendListRequested());
    _friendGmailETController = TextEditingController();
    super.initState();
  }

  //dispose
  @override
  void dispose() {
    _friendGmailETController.dispose();
    super.dispose();
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
        ],
      )),
    );
  }

  AppBar buildChatAppBar(BuildContext context) {
    return AppBar(
        elevation: 0,
        title: const Text(
          "Chats",
        ));
  }
}
