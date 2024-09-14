
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorwhatsapp/core/extention/extention_size.dart';
import 'package:mentorwhatsapp/core/utils/app_color.dart';
import 'package:mentorwhatsapp/core/widget/custom_text_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ 
              10.hs,
              SizedBox(
                width: 130.w,
                height: 130.h,
                child: CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: const AssetImage("assets/images/avatar.png"),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 1,
                              right: 5,
                              child: GestureDetector(
                                onTap: () async {},
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade400,
                                    border: Border.all(color: Colors.white, width: 3),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      
                                      ImagePicker()
                                          .pickImage(source: ImageSource.gallery);
                                          
                                    },
                                    child: const Icon(
                                      Icons.camera_alt_sharp,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                   
              ), 
              20.hs,
              CustomTextField(
                hintText: 'Enter Your name',
                suffixIcon: Icon(Icons.check , color: AppColors.greyLight,),
              ),
            ],
          ),
        )
      ),
    );
      }
    
  }

