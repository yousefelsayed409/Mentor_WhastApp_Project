import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorwhatsapp/features/Auth/SignIn/presentation/widget/signin_header_text.dart';
import 'package:mentorwhatsapp/core/utils/app_string.dart';
import 'package:mentorwhatsapp/features/Auth/SignUp/presentation/SignUp_Cubit/signup_cubit.dart';
import 'package:mentorwhatsapp/features/Auth/SignUp/presentation/widget/pic_image_widget.dart';
import 'package:path/path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/Havw_AnAcount.dart';
import '../widget/SignUp_Form.dart';
import '../widget/Welcom_TExt.dart';

class SignUPView extends StatelessWidget {
  const SignUPView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 32,
              ),
            ),
            const SliverToBoxAdapter(
              child: SignHeaderTitle(
                texttitle: AppStrings.createAccount,
                textsubtitle: AppStrings.subtitlesignup,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            
            SliverToBoxAdapter(
              child: SignUpForm(),
            ),
            const SliverToBoxAdapter(
              child: HaveAnAcountWidget(textsp: AppStrings.alreadyHaveAnAccount),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
