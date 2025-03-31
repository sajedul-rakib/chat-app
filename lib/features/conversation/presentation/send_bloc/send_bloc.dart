import 'package:bloc/bloc.dart';
import 'package:chat_app/features/conversation/datasource/repositories/message_repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'send_event.dart';

part 'send_state.dart';

class SendBloc extends Bloc<SendEvent, SendState> {
  final MessageRepositories _messageRepositories;

  SendBloc({required MessageRepositories messageRepositories})
      : _messageRepositories = messageRepositories,
        super(SendInitial()) {
    on<SendMessageRequest>((event, emit) async {
      emit(SendMessageStateLoading());
      try {
        bool result = await _messageRepositories.sendMessage(
            event.message, event.conversationId, event.token);
        if (result) {
          emit(SendMessageStateSuccess());
        } else {
          emit(SendMessageStateFailed(errMsg: "Send Message Failed"));
        }
      } catch (err) {
        emit(SendMessageStateFailed(errMsg: err.toString()));
      }
    });
  }
}
