import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentorwhatsapp/features/home/data/model/message.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  Future<void> createChat(String currentUserId, String otherUserId) async {
    try {
      emit(ChatLoading());
      
      List<String> ids = [currentUserId, otherUserId];
      ids.sort();
      String chatId = ids.join("_");

      DocumentReference chatDoc = FirebaseFirestore.instance.collection('chats').doc(chatId);

      DocumentSnapshot docSnapshot = await chatDoc.get();
      if (!docSnapshot.exists) {
        await chatDoc.set({
          'participants': [currentUserId, otherUserId],
          'messages': [],
        });
      }

      emit(ChatCreated());
    } catch (e) {
      emit(ChatError(error: e.toString()));
    }
  }

  Stream<List<Message>> getMessages(String chatId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .snapshots()
        .map((snapshot) {
          if (!snapshot.exists) return [];
          List<dynamic> messageData = snapshot.data()!['messages'] ?? [];
          return messageData.map((msg) => Message.fromJson(msg)).toList();
        });
  }

  Future<void> sendMessage(String chatId, Message message) async {
    try {
      DocumentReference chatDoc = FirebaseFirestore.instance.collection('chats').doc(chatId);
      await chatDoc.update({
        'messages': FieldValue.arrayUnion([message.toJson()]),
      });
    } catch (e) {
      emit(ChatError(error: e.toString()));
    }
  }
}
