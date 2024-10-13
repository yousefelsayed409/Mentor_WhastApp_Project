enum MessageType { text, image, audio, file } 

class Message {
  final String senderID;
  final String content;
  final DateTime sendAt;
  final MessageType messageType;
  final String? fileUrl; 

  Message({
    required this.senderID,
    required this.messageType,
    required this.sendAt,
    required this.content,
    this.fileUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'senderID': senderID,
      'content': content,
      'sendAt': sendAt.toIso8601String(),
      'messageType': messageType.index,
      'fileUrl': fileUrl,
    };
  }

  static Message fromJson(Map<String, dynamic> json) {
    return Message(
      senderID: json['senderID'],
      content: json['content'],
      sendAt: DateTime.parse(json['sendAt']),
      messageType: MessageType.values[json['messageType']],
      fileUrl: json['fileUrl'],   
    );
  }
}
