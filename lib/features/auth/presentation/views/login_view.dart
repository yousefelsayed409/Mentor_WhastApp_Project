import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_picker/country_picker.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorwhatsapp/core/utils/app_color.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';
import 'package:mentorwhatsapp/core/widget/csutom_navigat.dart';
import 'package:mentorwhatsapp/core/widget/custom_eleveted_button.dart';
import 'package:mentorwhatsapp/features/auth/presentation/views/verification_view.dart';
import 'package:mentorwhatsapp/features/auth/presentation/views/profile_view.dart';
import 'package:mentorwhatsapp/features/home/presentation/view/home_view.dart';
import 'package:mentorwhatsapp/features/splash/view/splash_view.dart';
import '../manger/auth_cubit/cubit/otp_cubit.dart';
import '../manger/auth_cubit/cubit/otp_state.dart';
import '../../../../core/widget/custom_icon_button.dart';
import '../../../../core/widget/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController; 
  final keyform = GlobalKey<FormState>();
  late OtpCubit otpCubit;

  @override
  void initState() {
    super.initState();
    countryNameController = TextEditingController();
    countryCodeController = TextEditingController();
    phoneNumberController = TextEditingController();
    otpCubit = OtpCubit(); 
  }

  @override
  void dispose() {
    countryNameController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    otpCubit.close(); 
    super.dispose();
  }

  void showCountryPickerBottomSheet() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: ['EG'],
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 600.h,
        backgroundColor: AppColors.backgroundDark,
        flagSize: 22,
        borderRadius: BorderRadius.circular(20),
        textStyle: TextStyle(color: AppColors.greyDark),
        inputDecoration: InputDecoration(
          labelStyle: TextStyle(color: AppColors.greyDark),
          prefixIcon: const Icon(
            Icons.language,
            color: AppColors.greenDark,
          ),
          hintText: 'Search country by code or name',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.greyDark.withOpacity(.2),
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.greenDark,
            ),
          ),
        ),
      ),
      onSelect: (country) {
        countryNameController.text = country.name;
        countryCodeController.text = country.phoneCode;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Enter your phone number',
          style: AppStyles.textStyle18,
        ),
        centerTitle: true,
        actions: [
          CustomIconButton(
            onPressed: () {},
            icon: Icons.more_vert,
          ),
        ],
      ),
      body: BlocBuilder<OtpCubit, OtpState>(
        bloc: otpCubit,
        builder: (context, state) {
          if (state is OtpLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is OtpError) {
            return Center(child: Text(state.error));
          }
          return Form(
            key: keyform,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'WhatsApp will need to verify your number. ',
                      style: AppStyles.textStyle15,
                      children: [
                        TextSpan(
                          text: "What's my number?",
                          style: AppStyles.textStyle15,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: CustomTextField(
                    controller: countryNameController,
                    readOnly: true,
                    suffixIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.greenDark,
                      size: 22,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Country is required';
                      }
                      return null;
                    },
                    onTap: showCountryPickerBottomSheet,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 70,
                        child: CustomTextField(
                          controller: countryCodeController,
                          prefixText: '+',
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Country code is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(
                          controller: phoneNumberController,
                          hintText: 'phone number',
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone number is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Carrier charges may apply',
                  style: AppStyles.textStyle13,
                ),  
               
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomContainerButton(
        onPressed: () {
          if (keyform.currentState!.validate()) {
            final phoneNumber = '+${countryCodeController.text}${phoneNumberController.text}';
            otpCubit.sendOtp(phoneNumber); 
          NavigationHelper.navigateTo(context, HomeView());
          }
        },
        text: 'Next',
        width: 90.w,
      ),
    );
  }
}
