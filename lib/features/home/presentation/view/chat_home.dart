import 'package:flutter/material.dart';
import 'package:mentorwhatsapp/core/utils/app_color.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';
import 'package:mentorwhatsapp/core/widget/csutom_navigat.dart';

import 'select_contact_page.dart';

class ChatHome extends StatelessWidget {
  ChatHome({super.key});

  final List<Map<String, dynamic>> chats = [
    {
      'name': 'John Doe',
      'message': 'Hello! How are you?',
      'time': '12:30 PM',
      'avatar': 'assets/images/avatar.png',
    },
    {
      'name': 'Jane Smith',
      'message': 'See you later!',
      'time': '11:15 AM',
      'avatar': 'assets/images/avatar.png',
    },
    {
      'name': 'Michael Johnson',
      'message': 'I\'ll call you back.',
      'time': '10:45 AM',
      'avatar': 'assets/images/avatar.png',
    },
    {
      'name': 'Emily Davis',
      'message': 'Can we reschedule?',
      'time': 'Yesterday',
      'avatar': 'assets/images/avatar.png',
    },
    {
      'name': 'David Wilson',
      'message': 'Good morning!',
      'time': 'Yesterday',
      'avatar': 'assets/images/avatar.png',
    },
     {
      'name': 'David Wilson',
      'message': 'Good morning!',
      'time': 'Yesterday',
      'avatar': 'assets/images/avatar.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(chat['avatar']), 
              radius: 25,
            ),
            title: Text(
              chat['name'],
              style: AppStyles.textStyl16
            ),
            subtitle: Text(
              chat['message'],
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              maxLines: 1,       
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              chat['time'],
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            onTap: () {
            },
          );
        },
        
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.green,
        onPressed: () {
          NavigationHelper.navigateTo(context, SelectContactPage());
        },
        child: const Icon(Icons.chat , ),
      ),
    );
  }
}
