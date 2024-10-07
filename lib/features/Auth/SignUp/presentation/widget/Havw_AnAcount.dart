import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentorwhatsapp/features/Auth/SignIn/presentation/Views/SignIn_screen.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';
import 'package:mentorwhatsapp/core/widget/csutom_navigat.dart';



class HaveAnAcountWidget extends StatelessWidget {
  const HaveAnAcountWidget({super.key, required this.textsp});
  final String textsp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: textsp, style: AppStyles.textStyle15
              //  CustomTextStyles.poppins400style12 
               ),
            ],
          ),
        ),
        SignText(
          text: 'SignIn',
          press: () { 
            NavigationHelper.navigateReplacement(context , SignInview());
            // CustomNavigatePushReplace(context, '/SignIn');
          },
        )
      ],
    );
  }
}

class SignText extends StatelessWidget {
  SignText({super.key, required this.text, this.press});
  final String text;
  void Function()? press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: press,
        child: Text(
          text,
          style: AppStyles.textStyle18,
        ));
  }
}
