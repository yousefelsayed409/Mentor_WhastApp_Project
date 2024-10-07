import 'package:flutter/material.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';

class SelectContactPage extends StatelessWidget {
  SelectContactPage({super.key});

  final List<Map<String, dynamic>> contacts = [
    {
      'name': 'John Doe',
      'avatar': 'assets/images/avatar.png',
    },
    {
      'name': 'Jane Smith',
      'avatar': 'assets/images/avatar.png',
    },
    {
      'name': 'Michael Johnson',
      'avatar': 'assets/images/avatar.png',
    },
    {
      'name': 'Emily Davis',
      'avatar': 'assets/images/avatar.png',
    },
    {
      'name': 'David Wilson',
      'avatar': 'assets/images/avatar.png',
    },
    {
      'name': 'Sara Lee',
      'avatar': 'assets/images/avatar.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Contact', style: TextStyle(letterSpacing: 1)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];

          return ListTile(
            contentPadding: EdgeInsets.all(8),
            leading: CircleAvatar(
              backgroundImage: AssetImage(contact['avatar']),   
              radius: 25,
            ),
            title: Text(
              contact['name'],
              style: AppStyles.textStyl16
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Start chat with ${contact['name']}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
