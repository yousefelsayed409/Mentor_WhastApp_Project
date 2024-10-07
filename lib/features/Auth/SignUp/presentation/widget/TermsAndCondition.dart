import 'package:flutter/cupertino.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';

import '../../../../../../core/utils/App_String.dart';
import 'CheckBox.dart';

class TermsAndConditionWidget extends StatelessWidget {
  const TermsAndConditionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CheckBoxWidget(),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: AppStrings.iHaveAgreeToOur,
                  style: AppStyles.textStyle13),
              TextSpan(
                  text: AppStrings.termsAndCondition,
                  style: AppStyles.textStyle13.copyWith(
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
