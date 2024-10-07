import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentorwhatsapp/core/utils/App_String.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';



class ForgetPasswordWidget extends StatelessWidget {
   ForgetPasswordWidget({super.key , this.onTap});
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topRight,
        child: InkWell(
          onTap: onTap,
          child: Text(
            AppStrings.forgotPassword,
            style:AppStyles.textStyle15,
          ),
        ));
  }
}