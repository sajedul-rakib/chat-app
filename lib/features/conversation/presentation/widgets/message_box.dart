import 'package:chat_app/features/conversation/datasource/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../theme/color_scheme.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.bubbleType,
    required this.message,
  });

  final BubbleType bubbleType;
  final Message message;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      backGroundColor: bubbleType != BubbleType.sendBubble
          ? Theme.of(context).brightness == Brightness.light
              ? ColorSchemed.lightColorScheme.tertiary.withValues(alpha: 7)
              : Theme.of(context).colorScheme.primary.withValues(alpha: .6)
          : Theme.of(context).colorScheme.secondary,
      elevation: 0,
      clipper: ChatBubbleClipper5(type: bubbleType),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            message.msg ?? '',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 18,
                  color: bubbleType != BubbleType.sendBubble
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSecondary,
                ),
          ),
          const SizedBox(
            height: 5,
          ),
          if (bubbleType == BubbleType.receiverBubble)
            Text(
              timeago.format(DateTime.parse(
                  message.createdAt ?? DateTime.now().toString())),
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          if (bubbleType == BubbleType.sendBubble)
            Row(
              children: [
                Text(
                  '${timeago.format(DateTime.parse(message.createdAt ?? DateTime.now().toString()))} . ',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xffF7F7FC)
                            : Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(width: 5),
                // Add space between the time and the "Read" text
                Text(
                  "Read",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xffF7F7FC)
                            : Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
