class Message {
  String? sId;
  String? conversationId;
  String? sender;
  String? receiver;
  String? msg;
  String? messageType;
  List<String>? seenBy;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Message(
      {this.sId,
        this.conversationId,
        this.sender,
        this.receiver,
        this.msg,
        this.messageType,
        this.seenBy,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    conversationId = json['conversationId'];
    sender = json['sender'];
    receiver = json['receiver'];
    msg = json['msg'];
    messageType = json['messageType'];
    seenBy = json['seenBy'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['conversationId'] = conversationId;
    data['sender'] = sender;
    data['receiver'] = receiver;
    data['msg'] = msg;
    data['messageType'] = messageType;
    data['seenBy'] = seenBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
