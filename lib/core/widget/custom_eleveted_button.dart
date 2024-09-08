import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentorwhatsapp/core/utils/app_color.dart';
import 'package:mentorwhatsapp/core/utils/app_styles.dart';
import 'base_button.dart';

class CustomContainerButton extends BaseButton {
  const CustomContainerButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
     EdgeInsets? pading,
    EdgeInsets? margin,
    VoidCallback? onPressed,
    Alignment? alignment,
    TextStyle? buttonTextStyle,
    bool? isDisabled,
    double? height,
    double? width,
    this.backgroundColor,
    this.controller,
    required String text,
  }) : super(
          text: text,
          padding: pading,
          onPressed: onPressed,
          isDisabled: isDisabled,
          buttonTextStyle: buttonTextStyle,
          height: height,
          width: width,
          alignment: alignment,
          margin: margin,
        );

  final BoxDecoration? decoration;
  final PageController? controller;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildContainerButtonWidget,
          )
        : buildContainerButtonWidget;
  }

  Widget get buildContainerButtonWidget => GestureDetector(
        onTap: isDisabled ?? false ? null : onPressed ?? () {},
        child: Container(
          padding: padding ,
          height: height ?? 62.h,
          width: width ?? double.maxFinite,
          margin: margin,
          decoration: decoration ??
              BoxDecoration(
                color: isDisabled ?? false ? Colors.grey : AppColors.green,
                borderRadius: BorderRadius.circular(6),
              ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (leftIcon != null) ...[
                  leftIcon!,
                  SizedBox(width: 8.w),
                ],
                Text(
                  text,
                  style: buttonTextStyle ?? AppStyles.textStyle13,
                ),
                if (rightIcon != null) ...[
                  SizedBox(width: 8.w),
                  rightIcon!,
                ],
              ],
            ),
          ),
        ),
      );
}
