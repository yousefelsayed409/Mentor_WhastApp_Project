import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorwhatsapp/core/services/app_services.dart';  
import 'package:mentorwhatsapp/core/utils/app_color.dart';
import 'package:mentorwhatsapp/features/home/data/model/message.dart';
import 'package:mentorwhatsapp/features/home/presentation/manger/cubit/chat_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String userName;

  const ChatScreen({Key? key, required this.userId, required this.userName})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  late final String currentUserId;
  final ScrollController _scrollController = ScrollController();
  final AppService appService = AppService();
  bool _showEmojiPicker = false;
  String userStatus = "Offline"; 

  @override
  void initState() {
    super.initState();
    currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    chatCubit.createChat(currentUserId, widget.userId);
    
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .snapshots()
        .listen((userSnapshot) {
      if (userSnapshot.exists) {
        setState(() {
          userStatus = userSnapshot.data()?['isOnline'] ? "Online" : "Offline"; 
        });
      }
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendImage(String chatId) async {
    final XFile? pickedFile = await appService.getImageFromGallery();
    if (pickedFile != null) {
      final File file = File(pickedFile.path);
      final imageUrl = await appService.uploadImageUser(file: file, uid: currentUserId);
      
      if (imageUrl != null) {
        final imageMessage = Message(
          senderID: currentUserId,
          messageType: MessageType.image,   
          sendAt: DateTime.now(),
          content: imageUrl, 
        );

        BlocProvider.of<ChatCubit>(context).sendMessage(chatId, imageMessage);
      }
    }
  }

  Future<void> _sendFile(String chatId) async {
    final XFile? pickedFile = await appService.getFileFromGallery();
    if (pickedFile != null) {
      final File file = File(pickedFile.path);
      final fileUrl = await appService.uploadFile(file: file, uid: currentUserId);
      
      if (fileUrl != null) {
        final fileMessage = Message(
          senderID: currentUserId,
          messageType: MessageType.file,
          sendAt: DateTime.now(),
          content: fileUrl, 
        );

        BlocProvider.of<ChatCubit>(context).sendMessage(chatId, fileMessage);
      }
    }
  }  

  void _onEmojiSelected(String emoji) {
    _controller.text += emoji;
    setState(() {
      _showEmojiPicker = false;
    });
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    List<String> ids = [currentUserId, widget.userId];
    ids.sort();
    String chatId = ids.join("_");

    return Scaffold(
      appBar: AppBar(title:  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Text(
                        widget.userName,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        userStatus,
                        style: TextStyle(
                          fontSize: 17,
                          color: userStatus == "Online" ? Colors.green : Colors.grey, 
                        ),
                      ),
                    ],
                  ),
                ),),
      body: GestureDetector(
        onTap: () {
          if (_showEmojiPicker) {
            setState(() {
              _showEmojiPicker = false;
            });
          }
        },
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatError) {
              return Center(child: Text('حدث خطأ: ${state.error}'));
            }

            return Column(
              children: [
               
                Expanded(
                  child: StreamBuilder<List<Message>>(
                    stream: chatCubit.getMessages(chatId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Center(child: Text('حدث خطأ أثناء تحميل الرسائل.'));
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('لا توجد رسائل بعد.'));
                      }

                      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());     

                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final message = snapshot.data![index];
                          final isMe = message.senderID == currentUserId;

                          return ChatBubble(
                            clipper: isMe
                                ? ChatBubbleClipper1(type: BubbleType.sendBubble)
                                : ChatBubbleClipper10(type: BubbleType.receiverBubble),
                            alignment: isMe ? Alignment.topRight : Alignment.topLeft,
                            margin: const EdgeInsets.only(top: 10),
                            backGroundColor: isMe ? AppColors.primercolortow : AppColors.greyBackground,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                children: [
                                  if (message.messageType == MessageType.text)
                                    Text(
                                      message.content,
                                      style: TextStyle(color: isMe ? Colors.white : Colors.white, fontSize: 16),
                                    ),
                                  if (message.messageType == MessageType.image)
                                    Image.network(message.content, height: 150, fit: BoxFit.fill),
                                  if (message.messageType == MessageType.file)
                                    TextButton(
                                      onPressed: () {
                                      },
                                      child: Text('تحميل ملف', style: TextStyle(color: isMe ? Colors.white : Colors.black)),
                                    ),
                                  const SizedBox(height: 4),
                                  Text(
                                    DateFormat('HH:mm').format(message.sendAt),
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                if (_showEmojiPicker)
                  EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      _onEmojiSelected(emoji.emoji);
                    },
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.image),
                        onPressed: () => _sendImage(chatId),
                      ),
                      IconButton(
                        icon: const Icon(Icons.attach_file),
                        onPressed: () => _sendFile(chatId),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            labelText: 'أدخل رسالتك...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            final newMessage = Message(
                              senderID: currentUserId,
                              messageType: MessageType.text,
                              sendAt: DateTime.now(),
                              content: _controller.text,
                            );

                            chatCubit.sendMessage(chatId, newMessage);
                            _controller.clear();
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.emoji_emotions),
                        onPressed: _toggleEmojiPicker,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
