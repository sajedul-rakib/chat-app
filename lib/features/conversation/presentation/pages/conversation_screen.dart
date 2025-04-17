import 'dart:convert';

import 'package:chat_app/features/chats/data/models/user.dart';
import 'package:chat_app/features/conversation/datasource/models/message.dart';
import 'package:chat_app/features/conversation/presentation/bloc/message_bloc.dart';
import 'package:chat_app/features/conversation/presentation/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../widgets/message_input_field.dart';
import '../widgets/show_messages.dart';

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
  late io.Socket _socket;
  late Message _message;

  @override
  void initState() {
    super.initState();
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
    if (_message.conversationId == widget.conversationId) {
      context.read<MessageBloc>().add(NewMessageReceived(_message));
    }
  }

  @override
  void dispose() {
    _socket.emit("leave_chat", {'userId': widget.loggedUserId});
    _socket.disconnect();
    _socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: conversationAppBar(context, widget.friendUser),
      backgroundColor: isDark ? const Color(0xff152033) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ShowMessages(
              loggedUserId: widget.loggedUserId,
            ),
            MessageInputField(
              loggedUserId: widget.loggedUserId,
              friendUserId: widget.friendUser.sId!,
              conversationId: widget.conversationId,
            )
          ],
        ),
      ),
    );
  }
}
