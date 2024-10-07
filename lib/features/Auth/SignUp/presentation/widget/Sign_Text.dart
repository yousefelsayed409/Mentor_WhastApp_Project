import 'package:flutter/cupertino.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';


GestureDetector SignText(
      {required String text, required VoidCallback ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Text(
        text,
        style: AppStyles.poppins400style12
      ),
    );
  }
