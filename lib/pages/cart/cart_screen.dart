import 'package:coar/constants/app_constant.dart';
import 'package:coar/custom/widgets/container_custom.dart';
import 'package:coar/custom/widgets/text_custom.dart';
import 'package:coar/pages/cart/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: basecolor,
        title: TextCustomWidget(
          text: 'Cart',
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
 
        ),
      ),
      body: Column(
        children: [
          ContainerCustom(
            marginRight: 15.w,
            marginTop: 20.h,
            marginLeft: 15.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextCustomWidget(
                  text: 'Items 1',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  textColor: greycolor,
                ),
                TextCustomWidget(
                  text: '₹43000',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  textColor: greycolor,
                ),
              ],
            ),
          ),
          const CartTile()
        ],
      ),
      bottomNavigationBar: ContainerCustom(
        borderRadius: BorderRadius.circular(7.r),
        marginBottom: 10.h,
        marginRight: 15.w,
        marginLeft: 15.w,
        bgColor: primaryColor,
        height: 60.h,
        child: TextCustomWidget(
          fontWeight: FontWeight.w600,
          fontSize: 17.sp,
          textColor: whiteColor,
          text: 'PROCEED TO CHECKOUT',
          containerAlignment: Alignment.center,
        ),
      ),
    );
  }
}
