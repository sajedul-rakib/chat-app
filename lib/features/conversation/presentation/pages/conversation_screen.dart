import 'dart:convert';

import 'package:chat_app/features/chats/data/models/user.dart';
import 'package:chat_app/features/chats/presentation/bloc/online_user_bloc/online_user_bloc.dart';
import 'package:chat_app/features/conversation/datasource/models/message.dart';
import 'package:chat_app/features/conversation/presentation/bloc/message_bloc.dart';
import 'package:chat_app/features/widgets/circular_progress_indicator.dart';
import 'package:chat_app/features/widgets/custom_snackbar.dart';
import 'package:chat_app/theme/color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

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
  late io.Socket _socket;
  late Message _message;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get isMessageEmpty => _textEditingController.text.trim().isEmpty;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    context.read<MessageBloc>().add(
          GetMessageRequest(
            conversationId: widget.conversationId,
          ),
        );
    _socketConnect();
  }

  //socket
  void _socketConnect() {
    _socket = io.io(
        dotenv.env['BASE_URL'],
        io.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .enableReconnection()
            .build());
    _socket.connect();
    _setupSocketListeners();
  }

  //socket listener for new message
  void _setupSocketListeners() {
    //on connect
    _socket.onConnect((_) {});

    _socket.emit("join_chat", {
      'conversationId': widget.conversationId,
      'userId': widget.loggedUserId
    });

    //listening new message
    _socket.on("new_message", (data) {
      _handleNewMessage(data);
    });

    //socket on connection error
    _socket.onConnectError((err) {
      _socket.disconnect();
      _socket.dispose();
    });

    //socket error
    _socket.onError((_) {
      _socket.disconnect();
      _socket.dispose();
    });
  }

  //handle new message
  void _handleNewMessage(dynamic data) {
    _message = Message.fromJson(jsonDecode(jsonEncode(data['data'])));
    context.read<MessageBloc>().add(NewMessageReceived(_message));
  }

  @override
  void dispose() {
    _socket.emit("leave_chat", {'userId': widget.loggedUserId});
    _socket.disconnect();
    _socket.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  //send message process
  void _sendMessage() {
    if (!isMessageEmpty) {
      Map<String, dynamic> message = {
        'sender': widget.loggedUserId,
        'msg': _textEditingController.text.trim(),
        'receiver': widget.friendUser.sId
      };
      context.read<SendBloc>().add(SendMessageRequest(
            message: message,
            conversationId: widget.conversationId,
          ));
      _textEditingController.clear(); // Clear input after sending
      // Refresh UI to disable the send button
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: _buildAppBar(context),
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
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: sender
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                IntrinsicWidth(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.75),
                                    child: MessageBox(
                                      bubbleType: sender
                                          ? BubbleType.sendBubble
                                          : BubbleType.receiverBubble,
                                      message: message!,
                                    ),
                                  ),
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
              child: Row(
                spacing: 10,
                children: [
                  Expanded(
                    flex: 9,
                    child: Form(
                      key: _formKey,
                      child: InputFormField(
                        filledInput:
                            Theme.of(context).brightness == Brightness.dark
                                ? true
                                : false,
                        filledColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? ColorSchemed.darkColorScheme.primary
                                : ColorSchemed.lightColorScheme.tertiary
                                    .withValues(alpha: 10),
                        hintText: "Message",
                        textEditionController: _textEditingController,
                        onChange: (value) => setState(() {}),
                        prefix: const Icon(CupertinoIcons.mail),
                        suffix: InkWell(
                          onTap: _sendMessage,
                          child: const Icon(CupertinoIcons.paperplane_fill),
                        ),
                      ),
                    ),
                  ),
                  if (isMessageEmpty)
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: () {
                                    CustomSnackbar.show(
                                        context: context,
                                        message: "It's will update later");
                                  },
                                  child: Icon(FontAwesomeIcons.microphone))),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: () {
                                    CustomSnackbar.show(
                                        context: context,
                                        message: "It's will update later");
                                  },
                                  child: Icon(FontAwesomeIcons.image))),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //app bar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 10,
      title: InkWell(
        onTap: () {
          widget.friendUser.profilePic != null &&
                  widget.friendUser.profilePic!.isNotEmpty
              ? _showProfilePic(
                  '${dotenv.env['BASE_URL']}${widget.friendUser.profilePic!}',
                  widget.friendUser.fullName!,
                  widget.friendUser.email!)
              : null;
        },
        child: Row(
          children: [
            BlocBuilder<OnlineUserBloc, OnlineUserState>(
              builder: (context, state) {
                bool isOnline = false;
                if (state is OnlineUsersUpdated) {
                  isOnline = state.onlineUser.contains(widget.friendUser.sId);
                }

                return Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 3,
                          color: isOnline ? Colors.green : Colors.red),
                      shape: BoxShape.circle),
                  child: CircleAvatar(
                      backgroundImage: widget.friendUser.profilePic != null &&
                              widget.friendUser.profilePic!.isNotEmpty
                          ? NetworkImage(
                              '${dotenv.env['BASE_URL']}${widget.friendUser.profilePic!}')
                          : widget.friendUser.gender == 'female'
                              ? AssetImage('assets/images/female.jpg')
                              : AssetImage('assets/images/man.jpg')),
                );
              },
            ),
            const SizedBox(width: 6),
            Text(
              widget.friendUser.fullName ?? " ",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
      ),
      actions: [
        _buildAppBarAction(FontAwesomeIcons.phone, "It's will update later"),
        const SizedBox(
          width: 20,
        ),
        _buildAppBarAction(FontAwesomeIcons.video, "It's will update later"),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }

  Widget _buildAppBarAction(IconData icon, String message) {
    return InkWell(
      onTap: () => CustomSnackbar.show(context: context, message: message),
      child: Icon(icon),
    );
  }

  //show the profile pic of the friend and his/her name and email
  void _showProfilePic(String profilePicUrl, String fullName, String mail) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(profilePicUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                fullName,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                mail,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimary),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        );
      },
    );
  }
}
