part of 'message_bloc.dart';


abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object?> get props => [];
}

final class InitialMessageState extends MessageState{}

abstract class MessageStateFailed extends MessageState {
  final String? errMsg;
  const MessageStateFailed(this.errMsg);

  @override
  List<Object?> get props => [errMsg];
}

final class GetMessageStateLoading extends MessageState {
  const GetMessageStateLoading();
}

final class GetMessageStateSuccess extends MessageState {
  final MessageModel messageModel;
  const GetMessageStateSuccess({required this.messageModel});

  @override
  List<Object?> get props => [messageModel];
}

final class GetMessageStateFailed extends MessageStateFailed {
  const GetMessageStateFailed(super.errMsg);
}

// ✉️ Send Message States
final class SendMessageStateLoading extends MessageState {
  const SendMessageStateLoading();
}

final class SendMessageStateSuccess extends MessageState {
  const SendMessageStateSuccess();
}

final class SendMessageStateFailed extends MessageStateFailed {
  const SendMessageStateFailed(super.errMsg);
}
