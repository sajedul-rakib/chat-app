import 'dart:convert';

import 'package:chat_app/features/chats/data/models/user.dart';
import 'package:chat_app/features/conversation/datasource/models/message.dart';
import 'package:chat_app/features/conversation/presentation/bloc/message_bloc.dart';
import 'package:chat_app/features/widgets/circular_progress_indicator.dart';
import 'package:chat_app/features/widgets/custom_snackbar.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:chat_app/theme/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../signup/presentation/widget/text_form_field.dart';
import '../send_bloc/send_bloc.dart';
import '../widgets/message_box.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({
    super.key,
    required this.friendUser,
    required this.conversationId,
    required this.loggedUserId,
  });

  final User friendUser;
  final String conversationId;
  final String loggedUserId;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late TextEditingController _textEditingController;
  late IO.Socket _socket;
  late String token;
  late Message _message;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get isMessageEmpty => _textEditingController.text.trim().isEmpty;

  @override
  void initState() {
    super.initState();
    token = SharedData.token ?? '';
    _textEditingController = TextEditingController();
    if (token.isNotEmpty) {
      context.read<MessageBloc>().add(
            GetMessageRequest(
              conversationId: widget.conversationId,
              token: token,
            ),
          );
    }
    _socketConnect();
  }

  void _socketConnect() {
    _socket = IO.io(
        'http://192.168.0.100:3000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders(
                {'Authorization': 'Bearer $token'}) // Include token
            .build());
    _socket.connect();

    _socket.onConnect((data) {
      _socket.on("new_message", (data) {
        _message = Message.fromJson(jsonDecode(jsonEncode(data['data'])));
        context.read<MessageBloc>().add(NewMessageReceived(_message));
      });
    });

    _socket.onConnectError((err) {
      _socket.disconnect();
      _socket.dispose();
      return;
    });
  }

  @override
  void dispose() {
    _socket.disconnect();
    _socket.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_formKey.currentState?.validate() ?? false) {
      Map<String, dynamic> message = {
        'sender': widget.loggedUserId,
        'msg': _textEditingController.text.trim(),
        'receiver': widget.friendUser.sId
      };
      context.read<SendBloc>().add(SendMessageRequest(
          message: message,
          conversationId: widget.conversationId,
          token: token));
      _textEditingController.clear(); // Clear input after sending
      setState(() {}); // Refresh UI to disable the send button
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Row(
          children: [
            CircleAvatar(
              // If you want to show a profile picture, replace this placeholder.
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, color: Colors.black),
            ),
            const SizedBox(width: 10),
            Text(
              widget.friendUser.fullName ?? " ",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
        actions: [
          InkWell(
              onTap: () {
                CustomSnackbar.show(
                    context: context, message: "It's will update later");
              },
              child: Icon(FontAwesomeIcons.phone)),
          SizedBox(width: 20),
          InkWell(
              onTap: () {
                CustomSnackbar.show(
                    context: context, message: "It's will update later");
              },
              child: Icon(FontAwesomeIcons.video)),
          SizedBox(width: 20),
        ],
      ),
      backgroundColor: isDark ? const Color(0xff152033) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: BlocBuilder<MessageBloc, MessageState>(
                  builder: (context, state) {
                    if (state is GetMessageStateLoading) {
                      return const CustomCircularProgressIndicator();
                    } else if (state is GetMessageStateSuccess) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.messageModel.messages?.length ?? 0,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final message = state.messageModel.messages?[index];
                          final sender = message?.sender == widget.loggedUserId;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: sender
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                MessageBox(
                                  bubbleType: sender
                                      ? BubbleType.sendBubble
                                      : BubbleType.receiverBubble,
                                  message: message!,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (state is GetMessageStateFailed) {
                      return Center(
                        child: Text(
                          "Error: ${state.errMsg}",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: InputFormField(
                  filledInput: Theme.of(context).brightness == Brightness.dark
                      ? true
                      : false,
                  filledColor: Theme.of(context).brightness == Brightness.dark
                      ? ColorSchemed.darkColorScheme.primary
                      : ColorSchemed.lightColorScheme.tertiary
                          .withValues(alpha: 10),
                  hintText: "Message",
                  textEditionController: _textEditingController,
                  onChange: (value) => setState(() {}),
                  prefix: const Icon(CupertinoIcons.mail),
                  suffix: isMessageEmpty
                      ? InkWell(
                          onTap: () {
                            CustomSnackbar.show(
                                context: context, message: "Update will later");
                          },
                          child: Icon(CupertinoIcons.mic_fill))
                      : InkWell(
                          onTap: _sendMessage,
                          child: const Icon(CupertinoIcons.paperplane_fill),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
