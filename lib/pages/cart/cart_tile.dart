import 'package:coar/custom/widgets/container_custom.dart';
import 'package:coar/custom/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_constant.dart';


class CartTile extends StatelessWidget {
  const CartTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      borderRadius: BorderRadius.circular(7.r),
      bgColor: whiteColor,
      shadow: [
        BoxShadow(
            color: greycolor.withOpacity(.5),
            spreadRadius: 4.sp,
            blurRadius: 3.sp,
            offset: const Offset(0, 4))
      ],
      marginRight: 15.w,
      marginLeft: 15.w,
      marginTop: 20.h,
      height: 250.h,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerCustom(
                marginLeft: 5.w,
                marginTop: 10.h,
                alignment: Alignment.topLeft,
                height: 90.h,
                width: 90.h,
                child: Image.asset(
                  'asset/neckls.jpg',
                ),
              ),
              ContainerCustom(
                marginTop: 10.h,
                marginLeft: 7.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextCustomWidget(
                      text: 'Bloom ing Love Diamond Mangalsutra',
                      textColor: greycolor,
                    ),
                    TextCustomWidget(
                      marginTop: 10.h,
                      fontSize: 14.sp,
                      text: ' ₹4300',
                      textColor: greycolor,
                    ),
                    TextCustomWidget(
                      marginTop: 7.h,
                      // fontSize: 14.sp,
                      text: 'id : hdhvjrdkjhg342cjd',
                      textColor: greycolor,
                    ),
                    TextCustomWidget(
                      marginTop: 7.h,
                      // fontSize: 14.sp,
                      text: 'Quantity: 1',
                      textColor: greycolor,
                    ),
                    TextCustomWidget(
                      marginTop: 7.h,
                      // fontSize: 14.sp,
                      text: 'Weight in grams: 2.6',
                      textColor: greycolor,
                    ),
                    TextCustomWidget(
                      marginTop: 7.h,
                      // fontSize: 14.sp,
                      text: 'Diamond weight: .8',
                      textColor: greycolor,
                    ),
                    TextCustomWidget(
                      marginTop: 7.h,
                      // fontSize: 14.sp,
                      text: 'Size: 16',
                      textColor: greycolor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          ContainerCustom(
            marginTop: 5.h,
            bgColor: greycolor.withOpacity(.5),
            height: 2.h,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextCustomWidget(
                marginTop: 3.h,
                containerAlignment: Alignment.center,
                text: 'Romove',
                fontSize: 15.sp,
                textColor: greycolor,
              ),
              ContainerCustom(
                marginTop: 5.h,
                bgColor: greycolor.withOpacity(.5),
                width: 3.h,
                height:35.h,
              ),
              TextCustomWidget(
                marginTop: 3.h,
                containerAlignment: Alignment.center,
                text: 'Book Now',
                fontSize: 15.sp,
                textColor: greycolor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
