import 'package:chat_app/features/conversation/datasource/models/message.dart';
import 'package:chat_app/features/conversation/presentation/widgets/message_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';

class ShowMessages extends StatelessWidget {
  const ShowMessages({
    super.key,
    required this.loggedUserId,
    required this.messages,
  });

  final String loggedUserId;
  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: messages.length,
        reverse: true,
        itemBuilder: (context, index) {
          final message = messages[index];
          final sender = message.sender == loggedUserId;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment:
                  sender ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                IntrinsicWidth(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    child: MessageBox(
                      bubbleType: sender
                          ? BubbleType.sendBubble
                          : BubbleType.receiverBubble,
                      message: message,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
