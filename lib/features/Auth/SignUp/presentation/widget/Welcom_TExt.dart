import 'package:flutter/cupertino.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';


class WelcomText extends StatelessWidget {
  const WelcomText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Text(text,
            style: AppStyles.poppins500style14.copyWith(fontSize: 25)
                ));
  }
}
