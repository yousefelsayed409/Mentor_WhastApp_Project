import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('الإعدادات'),
      ),
      body: currentUser == null
          ? Center(child: Text('لا يوجد مستخدم مسجل الدخول'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      currentUser.photoURL ?? 'https://via.placeholder.com/150',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'اسم المستخدم: ${currentUser.displayName ?? 'غير متوفر'}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'البريد الإلكتروني: ${currentUser.email ?? 'غير متوفر'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 30),
                  
                ],
              ),
            ),
    );
  }
}
