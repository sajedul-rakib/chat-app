import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../signup/presentation/widget/text_form_field.dart';
import '../../../widgets/custom_snackbar.dart';
import '../send_bloc/send_bloc.dart';

class MessageInputField extends StatefulWidget {
  const MessageInputField(
      {super.key,
      required this.loggedUserId,
      required this.friendUserId,
      required this.conversationId});

  final String loggedUserId;
  final String friendUserId;
  final String conversationId;

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  //send message process
  void _sendMessage() {
    if (_textEditingController.text.isNotEmpty) {
      Map<String, dynamic> message = {
        'sender': widget.loggedUserId,
        'msg': _textEditingController.text.trim(),
        'receiver': widget.friendUserId
      };
      context.read<SendBloc>().add(SendMessageRequest(
            message: message,
            conversationId: widget.conversationId,
          ));
      // Clear input after sending
      _textEditingController.clear();
      //update the ui for disable send button
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        spacing: 10,
        children: [
          Expanded(
            flex: 9,
            child: Form(
              key: _formKey,
              child: InputFormField(
                onChange: (_) => setState(() {}),
                // filledInput: Theme.of(context).brightness == Brightness.dark
                //     ? true
                //     : false,
                //   Color(0xff0F1828)
                filledColor: Theme.of(context).brightness == Brightness.dark
                    ?Color(0xff0F1828)
                    : Color(0xffF7F7FC),
                hintText: "Message",
                textEditionController: _textEditingController,
                prefix: const Icon(CupertinoIcons.mail),
                suffix: InkWell(
                  onTap: _sendMessage,
                  child: const Icon(CupertinoIcons.paperplane_fill),
                ),
              ),
            ),
          ),
          if (_textEditingController.text.isEmpty)
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
    );
  }
}
