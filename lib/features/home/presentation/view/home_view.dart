import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorwhatsapp/core/utils/app_color.dart';
import 'package:mentorwhatsapp/core/widget/csutom_navigat.dart';
import 'package:mentorwhatsapp/core/widget/custom_icon_button.dart';
import 'package:mentorwhatsapp/core/widget/toast.dart';
import 'package:mentorwhatsapp/features/Auth/SignIn/presentation/SignIn_Cubit/cubit/sign_in_cubit.dart';
import 'package:mentorwhatsapp/features/Auth/SignIn/presentation/Views/SignIn_screen.dart';
import 'package:mentorwhatsapp/features/home/presentation/view/call_home.dart';
import 'package:mentorwhatsapp/features/home/presentation/view/chat_home.dart';
import 'package:mentorwhatsapp/features/home/presentation/view/setting_view.dart';
import 'package:mentorwhatsapp/features/home/presentation/view/status_home.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: const Text(
            'WhatsApp',
            style: TextStyle(letterSpacing: 1),
          ),
          elevation: 1,
          actions: [
            CustomIconButton(onPressed: () {}, icon: Icons.search),
            CustomIconButton(
                onPressed: () {
                  context.read<SignInCubit>().signOut().then((_) { 
                    toastMsg('Success LogOut');

                    NavigationHelper.navigateReplacement(context, const SignInview());
                  });
                },
                icon: Icons.logout),
            CustomIconButton(
              onPressed: () {

                NavigationHelper.navigateTo(context, SettingsView());
              },
              icon: Icons.settings,
            ),
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
            const ChatHome(),
            StatusHome(),
            CallPage(),
          ],
        ),
      ),
    );
  }
}
