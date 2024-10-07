import 'package:flutter/cupertino.dart';
import 'package:mentorwhatsapp/core/utils/app_assets.dart';
import 'package:mentorwhatsapp/core/utils/app_color.dart';


class ForgetPaswwordImage extends StatelessWidget {
  const ForgetPaswwordImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Image.asset(AppAssets.splashImageicon, color: AppColors.green,),
    );
  }
}
