import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentorwhatsapp/core/routes/app_route.dart';
import 'package:mentorwhatsapp/core/utils/app_assets.dart';
import 'package:mentorwhatsapp/core/utils/app_color.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';
import 'package:mentorwhatsapp/core/widget/csutom_navigat.dart';
import 'package:mentorwhatsapp/core/widget/custom_eleveted_button.dart';
import 'package:mentorwhatsapp/features/Auth/SignIn/presentation/Views/SignIn_screen.dart';
import 'package:mentorwhatsapp/features/home/presentation/view/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      
      FirebaseAuth.instance.currentUser == null
        ? Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInview()))
        : NavigationHelper.navigateTo(context, HomeView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              AppAssets.splashImageBackground,
              fit: BoxFit.cover,
            ),
          ),
          // Foreground Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to WhatsApp',
                style: AppStyles.textStyle30,
              ),
              SizedBox(height: 60.h),
              Image.asset(
                AppAssets.splashImageicon,
                width: 300.w,
                color: AppColors.green,
              ),
              SizedBox(height: 60.h),
              Text(
                'Read Our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service',
                style: AppStyles.textStyle13,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: CustomContainerButton(
                  onPressed: () {
                    navigateToLoginPage(context);
                  },
                  height: 47.h,
                  text: 'AGREE AND CONTINUE',
                  buttonTextStyle:
                      AppStyles.textStyle15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void navigateToLoginPage(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    AppRoute.signInView,
    (route) => false,
  );
}
