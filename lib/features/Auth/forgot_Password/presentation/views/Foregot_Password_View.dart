
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mentorwhatsapp/features/Auth/forgot_Password/presentation/widget/Forget_Form.dart';
import 'package:mentorwhatsapp/core/utils/App_String.dart';
import 'package:mentorwhatsapp/core/utils/app_color.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';

import '../../../SignUp/presentation/widget/Welcom_TExt.dart';
import '../widget/Image_Fogot.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 32,
          ),
        ),
        const SliverToBoxAdapter(
          child: WelcomText(text: AppStrings.forgotPasswordPage),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
        const SliverToBoxAdapter(
          child: ForgetPaswwordImage(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 24,
          ),
        ),
        const SliverToBoxAdapter(
          child: ForgotPasswordTitle(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
        SliverToBoxAdapter(
          child: ForgotPasswordForm(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 60,
          ),
        ),
      ],
    ));
  }
}

class ForgotPasswordTitle extends StatelessWidget {
  const ForgotPasswordTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Enter your registered email below to receivepassword reset instruction',
      textAlign: TextAlign.center,
      style: AppStyles.textStyle13.copyWith(color: AppColors.white),
    );
  }
}
