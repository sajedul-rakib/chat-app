import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/features/conversation/datasource/models/message.dart';
import 'package:chat_app/features/conversation/datasource/models/message_model.dart';
import 'package:chat_app/features/conversation/datasource/repositories/message_repositories.dart';
import 'package:equatable/equatable.dart';
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

    on<SendMessageRequest>((event, emit) async {
      emit(SendMessageStateLoading());
      try {
        bool result = await _messageRepositories.sendMessage(
            event.message, event.conversationId, event.token);
        if (result) {
          emit(SendMessageStateSuccess());
        } else {
          emit(SendMessageStateFailed("Send Message Failed"));
        }
      } catch (err) {
        emit(SendMessageStateFailed(err.toString()));
      }
    });
  }
}
