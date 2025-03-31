import 'package:bloc/bloc.dart';
import 'package:chat_app/features/conversation/datasource/models/message.dart';
import 'package:chat_app/features/conversation/datasource/models/message_model.dart';
import 'package:chat_app/features/conversation/datasource/repositories/message_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepositories _messageRepositories;

  MessageBloc({required MessageRepositories messageRepositories})
      : _messageRepositories = messageRepositories,
        super(InitialMessageState()) {
    on<GetMessageRequest>((event, emit) async {
      try {
        final result = await _messageRepositories.getMessage(
            conversationId: event.conversationId, token: event.token);
        emit(GetMessageStateSuccess(messageModel: result));
      } catch (err) {
        emit(GetMessageStateFailed(err.toString()));
      }
    });

    on<NewMessageReceived>((event, emit) {
      if (state is GetMessageStateSuccess) {
        final successState = state as GetMessageStateSuccess;

        // ✅ Create a new instance of MessageModel with updated messages list
        final updatedMessageModel = MessageModel(
          messages: [event.message, ...?successState.messageModel.messages],
        );

        // ✅ Emit new state with the updated model
        emit(GetMessageStateSuccess(messageModel: updatedMessageModel));
      }
    });
  }
}
