
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentorwhatsapp/core/widget/toast.dart';
import 'package:mentorwhatsapp/features/Auth/SignIn/presentation/SignIn_Cubit/cubit/sign_in_cubit.dart';
import 'package:mentorwhatsapp/features/Auth/SignIn/presentation/widget/signin_header_text.dart';
import 'package:mentorwhatsapp/features/Auth/forgot_Password/presentation/views/Foregot_Password_View.dart';
import 'package:mentorwhatsapp/core/utils/app_color.dart';
import 'package:mentorwhatsapp/core/utils/app_string.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';
import 'package:mentorwhatsapp/core/widget/aweson_dialg.dart';
import 'package:mentorwhatsapp/core/widget/csutom_navigat.dart';
import 'package:mentorwhatsapp/core/widget/custom_eleveted_button.dart';
import 'package:mentorwhatsapp/features/home/presentation/view/home_view.dart';

import '../../../SignUp/presentation/widget/Form_Field.dart';
import '../../../SignUp/presentation/widget/Welcom_TExt.dart';
import 'Forget_Password.dart';

class SigninForm extends StatelessWidget {
  SigninForm({super.key});

  final keyForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
toastMsg('Success Login');
          NavigationHelper.navigateReplacement(context , HomeView());
          // CustomNavigatePushReplace(context, '/homeNavBar');
          // FirebaseAuth.instance.currentUser!.emailVerified
          //     ?
          ///// 26
          //     : awesonDialogWidget(context, 'Please Verify Your Account');
          // toastMsg('Please Verify Your Account');
        } else if (state is SignInFailureState) {
          awesonDialogWidget(context, state.errorMessage);
          // toastMsg(state.errorMessage);
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<SignInCubit>(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: keyForm,
            child: Column(
          
              children: [
                const SizedBox(
                  height: 30  ,
                ),
                SignHeaderTitle(
                    texttitle: AppStrings.welcomeBack,
                    textsubtitle: AppStrings.subtitleSignin,
                  ),
                const SizedBox(
                  height: 30  ,
                ),
                CustomTextFormField(
                    onChanged: (email) {
                      cubit.email = email;
                    },
                    labelText: 'Email'),
                CustomTextFormField(
                  
                    onChanged: (password) {
                      cubit.password = password;
                    },
                    labelText: 'password'),
                const SizedBox(
                  height: 16,
                ),
                ForgetPasswordWidget(
                  onTap: () { 
                    NavigationHelper.navigateReplacement(context , ForgetPasswordView());
                    // CustomNavigatePushReplace(context, '/ForgotPassword');
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                state is SignInLoadingState
                    ? CircularProgressIndicator(
                        color: AppColors.white,
                      )
                    :  CustomContainerButton(text:'Sign In' ,
                    buttonTextStyle: AppStyles.textStyle15,
                onPressed: () {
                    if (keyForm.currentState!.validate()) {
                            BlocProvider.of<SignInCubit>(context)
                                .signinUserWithEmailAndPassword();
                          }
                },),
                const SizedBox(
                  height: 16,
                ),
               
                // CustomButton(
                //   color: AppColors.btncolor,
                //   textbtn: 'Signin with Google',
                //   onPressed: () {
                //     BlocProvider.of<SignInCubit>(context).signInWithGoogle();
                //   },
                // )
              ],
            ),
          ),
        );
      },
    );
  }
}
