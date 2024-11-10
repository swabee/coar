import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldCustom extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final double? width;
  final double? height;
  final double marginLeft;
  final double marginTop;
  final double marginRight;
  final double marginBottom;
  final BorderRadius? borderRadius;
  final Alignment? alignment;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final Color? fillColor;
  final Widget? prefix;
  final Widget? prefixIcon;
  final bool? disableBorder;
  final bool? isOtpField;
  final Widget? suffix;
  final Widget? suffixIcon;
  final VoidCallback? onSubmit;
  final bool? obscureText;
  final TextEditingController? controller;
  const TextFieldCustom(
      {Key? key,
      this.hintText,
      this.labelText,
      this.icon,
      this.prefix,
      this.prefixIcon,
      this.onChanged,
      this.width,
      this.height,
      this.marginLeft = 0,
      this.marginTop = 0,
      this.marginRight = 0,
      this.marginBottom = 0,
      this.borderRadius,
      this.alignment,
      this.keyboardType,
      this.textAlign,
      this.isOtpField,
      this.fillColor,
      this.disableBorder,
      this.suffix,
      this.suffixIcon,
      this.controller,
      this.onSubmit,
      this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 295.w,
      height: height ?? 48.h,
      margin: EdgeInsets.only(
        top: marginTop,
        left: marginLeft,
        right: marginRight,
        bottom: marginBottom,
      ),
      alignment: alignment ?? Alignment.center,
      child: TextField(
        obscureText: obscureText ?? false,
        onSubmitted: (_) {
          if (onSubmit != null) {
            onSubmit!();
          }
        },
        controller: controller,
        inputFormatters: isOtpField != null && isOtpField == true
            ? [
                LengthLimitingTextInputFormatter(1),
              ]
            : null,
        textAlign: textAlign ?? TextAlign.left,
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: fillColor,
          filled: fillColor != null ? true : false,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16.sp, // Adjust font size as needed
            color: Colors.grey.shade400, // Adjust color as needed
            // Set textAlign to center
          ),
          labelText: labelText,
          prefixIcon: prefixIcon,
          prefix: prefix,
          suffix: suffix,
          suffixIcon: suffixIcon,
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          border: disableBorder == true
              ? const UnderlineInputBorder()
              : OutlineInputBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(10.h),
                  borderSide: const BorderSide(
                    color:
                        Colors.grey, // replace with your unfocused border color
                  ),
                ),
          focusedBorder: disableBorder == true
              ? const UnderlineInputBorder()
              : OutlineInputBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(10.h),
                  borderSide: const BorderSide(
                    color:
                        Colors.black, // replace with your focused border color
                  ),
                ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
