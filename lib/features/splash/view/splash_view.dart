import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentorwhatsapp/core/routes/app_route.dart';
import 'package:mentorwhatsapp/core/utils/app_assets.dart';
import 'package:mentorwhatsapp/core/utils/app_color.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';

import '../../../core/widget/custom_eleveted_button.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

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
                      AppStyles.textStyle13.copyWith(color: AppColors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

 navigateToLoginPage(context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoute.loginview,
      (route) => false,
    );
  }