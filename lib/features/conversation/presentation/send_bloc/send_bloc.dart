import 'package:bloc/bloc.dart';
import 'package:chat_app/features/conversation/domain/repositories/message_repo.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'send_event.dart';

part 'send_state.dart';

class SendBloc extends Bloc<SendEvent, SendState> {
  final MessageRepo _messageRepositories;

  SendBloc({required MessageRepo messageRepositories})
      : _messageRepositories = messageRepositories,
        super(SendInitial()) {
    on<SendMessageRequest>((event, emit) async {
      emit(SendMessageStateLoading());
      try {
        final String token =await SharedData.getLocalSaveItem("token") ?? '';
        bool result = await _messageRepositories.sendMessage(
            event.message, event.conversationId, token);
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
