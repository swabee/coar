import 'package:coar/constants/app_constant.dart';
import 'package:coar/custom/container_custom.dart';
import 'package:coar/custom/text_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingTile extends StatelessWidget {
  const BookingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      marginTop: 10.h,
      marginBottom: 20.h,
      bgColor: whiteColor,
      shadow: [
        BoxShadow(
            color: basecolor,
            spreadRadius: 1.sp,
            blurRadius: 2.sp,
            offset: Offset(4, 4))
      ],
      borderRadius: BorderRadius.circular(6.r),
      marginRight: 15.w,
      marginLeft: 20.w,
      border: Border.all(color: basecolor),
      height: 60.h,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Image.asset('asset/photo_6181421562557742513_x.jpg'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustomWidget(
                marginTop: 10.h,
                marginLeft: 10.w,

                text: 'Mangal suthra 22 c',
                containerAlignment: Alignment.centerLeft,
                fontSize: 13.sp,
                textColor: Colors.grey,
                // fontWeight: FontWeight.bold,
              ),
              TextCustomWidget(
                marginLeft: 10.w,

                text: 'Order date : 28-12-2024',
                containerAlignment: Alignment.centerLeft,
                fontSize: 13.sp,
                textColor: Colors.grey,
                // fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            width: 40.w,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.phone,
                color: primaryColor,
              ))
        ],
      ),
    );
  }
}
