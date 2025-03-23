import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String? senderId;
  final String? recieverId;
  final String? message;
  final String? messageType;
  final bool? seen;

  const ChatModel(
      {this.senderId,
      this.recieverId,
      this.message,
      this.messageType,
      this.seen});

  Map<String, dynamic> toDocument() {
    return {
      'senderId': senderId,
      'receiverId': recieverId,
      'message': messageType,
      'messageType': messageType,
      'seen': seen
    };
  }

  static ChatModel fromDocument(Map<String, dynamic> data) {
    return ChatModel(
      senderId: data['senderId'],
      recieverId: data['receiverId'],
      message: data['message'],
      messageType: data['messageType'],
      seen: data['seen'],
    );
  }

  @override
  List<Object?> get props => [
        senderId,
        recieverId,
        messageType,
        message,
        seen,
      ];
}
