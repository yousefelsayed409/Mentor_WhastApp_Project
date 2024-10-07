import 'package:flutter/cupertino.dart';
import 'package:mentorwhatsapp/features/Auth/SignUp/presentation/views/SignUP_Screen.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';
import 'package:mentorwhatsapp/core/widget/csutom_navigat.dart';


import '../../../SignUp/presentation/widget/Havw_AnAcount.dart';

class DontHaveAcountWidget extends StatelessWidget {
  const DontHaveAcountWidget({super.key, required this.textsp});
  final String textsp;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: textsp, style: AppStyles.textStyle15),
            ],
          ),
        ),
        SignText(
          
          text: '  SignUp',
          press: () {
            NavigationHelper.navigateReplacement(context ,SignUPView());
            // CustomNavigatePushReplace(context, '/SignUp');
          },
        )
      ],
    );
    ;
  }
}
