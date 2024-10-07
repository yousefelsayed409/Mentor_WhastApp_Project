import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image }

class Message {
  final String senderID;
  final MessageType messageType;
  final DateTime sendAt;
  final String content;

  Message({
    required this.senderID,
    required this.messageType,
    required this.sendAt,
    required this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderID: json['senderID'],
      messageType: MessageType.values[json['messageType']],
      sendAt: (json['sendAt'] as Timestamp).toDate(),
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderID': senderID,
      'messageType': messageType.index,
      'sendAt': sendAt,
      'content': content,
    };
  }
}
