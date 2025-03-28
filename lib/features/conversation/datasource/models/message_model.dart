import 'message.dart';

class MessageModel {
  List<Message>? messages;

  MessageModel({this.messages});

  MessageModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      messages = <Message>[];
      json['data'].forEach((v) {
        messages!.add(Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (messages != null) {
      data['data'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

