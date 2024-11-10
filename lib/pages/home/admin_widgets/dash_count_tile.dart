import 'package:coar/constants/app_constant.dart';
import 'package:coar/custom/container_custom.dart';
import 'package:coar/custom/text_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashCountTile extends StatelessWidget {
  const DashCountTile(
      {super.key,
      required this.tileCOunt,
      required this.tileName,
      required this.voidCallback});
  final String tileName;
  final String tileCOunt;
  final VoidCallback voidCallback;
  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      callback: voidCallback,
      borderRadius: BorderRadius.circular(8.r),
      bgColor: whiteColor,
      shadow: [
        BoxShadow(
            color: basecolor,
            spreadRadius: 1.sp,
            blurRadius: 2.sp,
            offset: Offset(4, 4))
      ],
      border: Border.all(color: basecolor),
      width: 150.w,
      height: 90.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextCustomWidget(
            text: tileCOunt,
            containerAlignment: Alignment.center,
            fontSize: 16.sp,
            textColor: primaryColor,
            fontWeight: FontWeight.bold,
          ),
          TextCustomWidget(
            marginTop: 5.h,
            text: tileName,
            containerAlignment: Alignment.center,
            fontSize: 14.sp,
            textColor: primaryColor.withOpacity(.6),
          ),
        ],
      ),
    );
  }
}
