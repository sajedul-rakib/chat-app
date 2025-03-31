part of 'send_bloc.dart';

@immutable
abstract class SendState extends Equatable {}

final class SendInitial extends SendState {
  @override
  List<Object?> get props => [];
}

// ✉️ Send Message States
final class SendMessageStateLoading extends SendState {
  SendMessageStateLoading();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class SendMessageStateSuccess extends SendState {
  SendMessageStateSuccess();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class SendMessageStateFailed extends SendState {
  final String? errMsg;

  SendMessageStateFailed({this.errMsg});

  @override
  // TODO: implement props
  List<Object?> get props => [errMsg];
}
