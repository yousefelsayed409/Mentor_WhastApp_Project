import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorwhatsapp/core/services/app_services.dart';
import 'package:mentorwhatsapp/features/Auth/SignIn/presentation/Views/SignIn_screen.dart';
import 'package:mentorwhatsapp/features/Auth/SignUp/presentation/SignUp_Cubit/signup_cubit.dart';
import 'package:mentorwhatsapp/core/utils/app_color.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';
import 'package:mentorwhatsapp/core/widget/csutom_navigat.dart';
import 'package:mentorwhatsapp/core/widget/custom_eleveted_button.dart';
import 'package:mentorwhatsapp/core/widget/toast.dart';

import 'Form_Field.dart';
import 'TermsAndCondition.dart';
import 'pic_image_widget.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final keyForm = GlobalKey<FormState>();
  File? selectedImage; 
  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) async {
  if (state is SignupSuccessState) {
    if (selectedImage != null) {
      final uploadService = AppService();
      String? imageUrl = await uploadService.uploadImageUser(
        file: selectedImage!,
        uid: state.uid, 
      );
      if (imageUrl != null) {
        print('تم رفع الصورة بنجاح: $imageUrl');
      }
    }

toastMsg('Success SignUp');

    NavigationHelper.navigateReplacement(context, SignInview());
  } else if (state is SignupFailureState) {
    toastMsg(state.errorMessage);
  }
},
      builder: (context, state) {
        final cubit = BlocProvider.of<SignupCubit>(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: keyForm,
            child: Column(
              children: [ 
                PickImageWidget(
                  onImagePicked: (XFile image) {
                    setState(() {
                      selectedImage = File(image.path);
                    });
                  },
                ),
                CustomTextFormField(
                  onChanged: (name) {
                    cubit.name = name;
                  },
                  labelText: 'Name',
                ),
                CustomTextFormField(
                  onChanged: (email) {
                    cubit.email = email;
                  },
                  labelText: 'Email',
                ),
                CustomTextFormField(
                  onChanged: (password) {
                    cubit.password = password;
                  },
                  labelText: 'Password',
                ),
                const TermsAndConditionWidget(),
                const SizedBox(height: 50),

                
                const SizedBox(height: 16),

                state is SignupLoadingState
                    ? CircularProgressIndicator(
                        color: AppColors.green,
                      )
                    : CustomContainerButton(
                        buttonTextStyle: AppStyles.textStyle15,
                        backgroundColor: cubit.termsAndCondition == false
                            ? AppColors.grey
                            : AppColors.btncolor,
                        text: 'SignUp',
                        onPressed: () async {
                          if (cubit.termsAndCondition == true) {
                            if (keyForm.currentState!.validate()) {
                              BlocProvider.of<SignupCubit>(context)
                                  .createUserWithEmailAndPassword();
                            }
                          }
                        },
                      ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
