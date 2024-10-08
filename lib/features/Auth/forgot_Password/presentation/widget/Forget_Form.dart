
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentorwhatsapp/features/Auth/SignIn/presentation/SignIn_Cubit/cubit/sign_in_cubit.dart';
import 'package:mentorwhatsapp/features/Auth/SignIn/presentation/Views/SignIn_screen.dart';
import 'package:mentorwhatsapp/features/Auth/SignUp/presentation/widget/Form_Field.dart';
import 'package:mentorwhatsapp/core/utils/app_color.dart';
import 'package:mentorwhatsapp/core/utils/app_string.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';
import 'package:mentorwhatsapp/core/widget/csutom_navigat.dart';
import 'package:mentorwhatsapp/core/widget/custom_eleveted_button.dart';
import 'package:mentorwhatsapp/core/widget/toast.dart';



class ForgotPasswordForm extends StatelessWidget {
  ForgotPasswordForm({super.key});

  final keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is ForgorpasswordSuccessState) {
          toastMsg('Check Your Email To Verfiy');
          NavigationHelper.navigateReplacement(context , const SignInview());
        } else if (state is ForgorpasswordFailureState) {
          toastMsg(state.errorMessage);
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<SignInCubit>(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: keyForm,
            child: Column(
              children: [
                CustomTextFormField(
                  labelText: 'Email Adderss',
                  onChanged: (email) {
                    cubit.email = email;
                  },
                ),
                const SizedBox(
                  height: 102,
                ),
                state is SignInLoadingState
                    ? const CircularProgressIndicator(
                        color: AppColors.green,
                      )
                    :  
                    Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: CustomContainerButton(
                  onPressed: () {
                          if (keyForm.currentState!.validate()) {
                            BlocProvider.of<SignInCubit>(context)
                                .forgotPasswordWithEmail();
                          }
                        },
                  height: 47.h,
                  text:  AppStrings.sendResetPasswordLink,
                  buttonTextStyle:
                      AppStyles.textStyle15,
                ),
              ),
              ],
            ),
          ),
        );
      },
    );
  }
}
