import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorwhatsapp/features/home/data/model/user_model.dart';
import 'package:mentorwhatsapp/features/home/presentation/manger/cubit/chat_cubit.dart';
import 'package:mentorwhatsapp/features/home/presentation/view/chat_screen_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatHome extends StatelessWidget {
  const ChatHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('حدث خطأ أثناء جلب المستخدمين.'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('لا يوجد مستخدمين.'));
          }

          List<UserModel> users = snapshot.data!.docs.map((doc) {
            return UserModel.fromJson(doc.data() as Map<String, dynamic>);
          }).toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              UserModel user = users[index];

              if (user.uid == currentUserId) return Container();

              return Padding(
                padding: const EdgeInsets.all(4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.pfpURL.isNotEmpty ? user.pfpURL : 'assets/images/avatar.png'), // صورة المستخدم
                  ),
                  title: Text(user.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => ChatCubit(),
                          child: ChatScreen(userId: user.uid, userName: user.name),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
