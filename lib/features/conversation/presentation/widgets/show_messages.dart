import 'package:chat_app/features/conversation/presentation/widgets/message_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';

import '../../../widgets/circular_progress_indicator.dart';
import '../bloc/message_bloc.dart';

class ShowMessages extends StatelessWidget {
  const ShowMessages({
    super.key,
    required this.loggedUserId,
  });

  final String loggedUserId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  final sender = message?.sender == loggedUserId;

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
                                    MediaQuery.of(context).size.width * 0.75),
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
    );
  }
}
