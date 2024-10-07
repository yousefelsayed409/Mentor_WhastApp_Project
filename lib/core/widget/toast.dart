import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mentorwhatsapp/core/utils/app_color.dart';


void toastMsg(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 50,
      backgroundColor: AppColors.white,
      textColor: Colors.black,
      fontSize: 16.0);
}


