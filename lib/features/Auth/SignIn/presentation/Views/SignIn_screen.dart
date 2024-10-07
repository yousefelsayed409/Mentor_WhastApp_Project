
import 'package:flutter/material.dart';
import 'package:mentorwhatsapp/features/Auth/SignIn/presentation/widget/Dont_Have_acount.dart';

import '../widget/SignIn_Form.dart';

class SignInview extends StatelessWidget {
  const SignInview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
           
            const SizedBox(
              height: 32,
            ),
            SigninForm(),

            const SizedBox(
              height: 16,
            ),
            const DontHaveAcountWidget(textsp: 'Don’t have an account ?')
          ],
        ),
      ),
    );
  }
}
