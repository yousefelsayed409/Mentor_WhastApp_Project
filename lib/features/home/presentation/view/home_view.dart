import 'package:flutter/material.dart';
import 'package:mentorwhatsapp/core/utils/app_color.dart';
import 'package:mentorwhatsapp/core/widget/custom_icon_button.dart';
import 'package:mentorwhatsapp/features/home/presentation/view/call_home.dart';
import 'package:mentorwhatsapp/features/home/presentation/view/chat_home.dart';
import 'package:mentorwhatsapp/features/home/presentation/view/status_home.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'WhatsApp',
            style: TextStyle(letterSpacing: 1),
          ),
          elevation: 1,
          actions: [
            CustomIconButton(onPressed: () {}, icon: Icons.search),
            CustomIconButton(onPressed: () {}, icon: Icons.more_vert),
          ],
          bottom: const TabBar(
            indicatorColor: AppColors.green,
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            splashFactory: NoSplash.splashFactory,
            tabs: [
              Tab(text: 'CHATS'),
              Tab(text: 'STATUS'),
              Tab(text: 'CALLS'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ChatHome(),
            StatusHome(),
            CallPage(),
          ],
        ),
      ),
    );
  }
}
