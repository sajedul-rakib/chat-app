import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.bubbleType,
    required this.message,
  });

  final BubbleType bubbleType;
  final String message;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      backGroundColor: bubbleType != BubbleType.sendBubble
          ? Theme.of(context).colorScheme.primary.withValues(alpha: .8)
          : Theme.of(context).colorScheme.secondary,
      elevation: 0,
      clipper: ChatBubbleClipper5(type: bubbleType),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            message,
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
              "${DateTime.now().hour}:${DateTime.now().minute}",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          if (bubbleType == BubbleType.sendBubble)
            Row(
              children: [
                Text(
                  '${DateTime.now().hour}:${DateTime.now().minute} . ',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xffF7F7FC)
                        : Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 5), // Add space between the time and the "Read" text
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
