import 'message.dart';

class Chat {
  final String id; 
  final List<String> participants; 
  final List<Message> messages;   

  Chat({
    required this.id,
    required this.participants,
    required this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> jsonData) {
    return Chat(
      id: jsonData['id'] ?? '', 
      participants: List<String>.from(jsonData['participants'] ?? []), 
      messages: (jsonData['messages'] as List<dynamic>? ?? [])
          .map((messageData) => Message.fromJson(messageData))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, 
      'participants': participants, 
      'messages': messages.map((message) => message.toJson()).toList(), 
    };
  }
}
