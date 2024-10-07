import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/App_Color.dart';
import '../views/SignUP_Screen.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.labelText,
      this.onChanged,
      this.onFieldSubmitted});
  final String labelText;
  void Function(String)? onFieldSubmitted;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, top: 16),
      child: TextFormField(
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        validator: (value) {
          if (value!.isEmpty) {
            return ' Please Enter Value';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          label: Text(labelText),
          labelStyle: TextStyle(color: AppColors.white),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.green),
            borderRadius: BorderRadius.circular(8),
          ),
          border: getoutlineBorder(),
        ),
      ),
    );
  }
}

OutlineInputBorder getoutlineBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.grey),
    borderRadius: BorderRadius.circular(8),
  );
}
