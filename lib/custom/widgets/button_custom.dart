
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_constant.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    Key? key,
    required this.text,
    required this.callback,
    this.btnHeight,
    this.btnWidth,
    this.btnColor,
    this.borderRadius,
    this.dontApplyMargin,
    this.isDisabled,
    this.borderSide = BorderSide.none,
    this.textStyle,
    this.margin,
    this.inProgress,
    this.padding,
    this.splashColor,
    this.isPositive,
  }) : super(key: key);

  final double? btnHeight;
  final double? btnWidth;
  final String text;
  final TextStyle? textStyle;
  final Color? btnColor;
  final VoidCallback? callback;
  final BorderRadius? borderRadius;
  final bool? dontApplyMargin;
  final bool? isDisabled;
  final BorderSide borderSide;
  final EdgeInsets? margin;
  final bool? inProgress;
  final EdgeInsetsGeometry? padding;
  final Color? splashColor;
  final bool? isPositive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10.h)),
        color: (callback == null || isDisabled == true)
            ? Colors.grey
            : primaryColor,
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: (callback == null || isDisabled == true)
        //       ? [Colors.grey, Colors.grey]
        //       : [const Color(0xFF87CEEB), const Color(0xFF1B7A9F)],
        // ),
      ),
      margin: margin ??
          EdgeInsets.symmetric(horizontal: dontApplyMargin == true ? 0 : 20),
      height: btnHeight ?? 45.h,
      width: btnWidth ?? btnWidth,
      alignment: Alignment.center,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: btnColor,
          foregroundColor: splashColor ?? Colors.white24,
          padding: padding ?? const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10.h),
            side: borderSide,
          ),
        ),
        onPressed: (callback == null || isDisabled == true)
            ? null
            : () {
                callback!();
              },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            // color: Colors.black,

            // height: btnHeight ?? 48.h,
            alignment: Alignment.center,
            child: (inProgress == true)
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    text,
                    style: textStyle ??
                        TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                  ),
          ),
        ),
      ),
    );
  }
}
