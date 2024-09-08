import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 
import 'package:mentorwhatsapp/core/utils/app_color.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';
import 'package:mentorwhatsapp/core/widget/custom_icon_button.dart';
import 'package:mentorwhatsapp/core/widget/custom_text_field.dart';

import '../manger/auth_cubit/cubit/otp_cubit.dart';
import '../manger/auth_cubit/cubit/otp_state.dart'; 

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Verify your number',
          style: AppStyles.textStyle13,
        ),
        actions: [
          CustomIconButton(
            onPressed: () {},
            icon: Icons.more_vert,
          ),
        ],
      ),
      body: BlocListener<OtpCubit, OtpState>(
        listener: (context, state) {
            if (state is OtpVerified) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('OTP Verified')),
            );
            //  successful OTP verification then Nav to home 
          } else if (state is OtpError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.h),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppStyles.textStyle13,
                    children: [
                      const TextSpan(
                        text:
                            "You've tried to register +251935838471. before requesting an SMS or Call with your code.",
                      ),
                      TextSpan(
                        text: "Wrong number?",
                        style: AppStyles.textStyle13,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:  EdgeInsets.symmetric(horizontal: 80.h),
                child: BlocBuilder<OtpCubit, OtpState>(
                  builder: (context, state) {
                    return CustomTextField(
                      controller: otpController,
                      hintText: "- - -  - - -",
                      fontSize: 30,
                      autoFocus: true,
                      keyboardType: TextInputType.number,
                      onTap: () {
                         final otp = otpController.text;
                          context.read<OtpCubit>().verifyOtp(otp);
                        
                      },
                     
                    );
                    
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Enter 6-digit code',
                style: AppStyles.textStyle13,
              ),
               SizedBox(height: 30.h),
              Row(
                children: [
                  Icon(Icons.message, color: AppColors.greenDark),
                   SizedBox(width: 20.w),
                  Text(
                    'Resend SMS',
                    style: AppStyles.textStyle13,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(
                color: AppColors.greyLight,
              ),
              const SizedBox(height: 10),
              
            ],
          ),
        ),
      ),
    );
  }
}
