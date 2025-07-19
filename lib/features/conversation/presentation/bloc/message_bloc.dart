import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/features/conversation/datasource/models/message.dart';
import 'package:chat_app/features/conversation/datasource/models/message_model.dart';
import 'package:chat_app/features/conversation/domain/repositories/message_repo.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepo _messageRepositories;

  MessageBloc({required MessageRepo messageRepositories})
      : _messageRepositories = messageRepositories,
        super(InitialMessageState()) {
    on<GetMessageRequest>((event, emit) async {
      try {
        final token = await SharedData.getLocalSaveItem('token') ?? " ";
        final result = await _messageRepositories.getMessage(
            conversationId: event.conversationId, token: token);
        emit(GetMessageStateSuccess(
            messageModel: MessageModel.fromJson(result.body!)));
      } catch (err) {
        emit(GetMessageStateFailed(err.toString()));
      }
    });

    on<NewMessageReceived>((event, emit) {
      if (state is GetMessageStateSuccess) {
        final successState = state as GetMessageStateSuccess;
        final updatedMessageModel = MessageModel(
          messages: [
            event.message,
            ...successState.messageModel.messages ?? [],
          ],
        );
        emit(GetMessageStateSuccess(messageModel: updatedMessageModel));
      }
    });
  }
}
