import 'package:chat_app/features/conversation/datasource/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../theme/color_scheme.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({
    super.key,
    required this.bubbleType,
    required this.message,
  });

  final BubbleType bubbleType;
  final Message message;

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _bubbleAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(microseconds: 2000));
    _bubbleAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset.zero)
        .animate(_controller);

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _bubbleAnimation,
        builder: (context, _) {
          return SlideTransition(
            position: _bubbleAnimation,
            child: ChatBubble(
              backGroundColor: widget.bubbleType != BubbleType.sendBubble
                  ? Theme.of(context).brightness == Brightness.light
                      ? ColorSchemed.lightColorScheme.tertiary
                          .withValues(alpha: 7)
                      : Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: .6)
                  : Theme.of(context).colorScheme.secondary,
              elevation: widget.bubbleType == BubbleType.receiverBubble ? 2 : 0,
              clipper: ChatBubbleClipper5(type: widget.bubbleType),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (widget.message.messageType == 'text')
                    Text(
                      widget.message.msg ?? '',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 18,
                            color: widget.bubbleType != BubbleType.sendBubble
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSecondary,
                          ),
                      textAlign: TextAlign.justify,
                    ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (widget.bubbleType == BubbleType.receiverBubble)
                    Text(
                      timeago.format(DateTime.parse(widget.message.createdAt ??
                          DateTime.now().toString())),
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  if (widget.bubbleType == BubbleType.sendBubble)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${timeago.format(DateTime.parse(widget.message.createdAt ?? DateTime.now().toString()))} . ',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xffF7F7FC)
                                        : Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        SizedBox(width: 5),
                        // Add space between the time and the "Read" text
                        Text(
                          "Read",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xffF7F7FC)
                                        : Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        });
  }
}
