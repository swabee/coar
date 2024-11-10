
import 'package:coar/constants/app_constant.dart';
import 'package:coar/pages/see_all/see_all_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../custom/widgets/container_custom.dart';

class BestSellTileCustom extends StatelessWidget {
  final String imageUrl;
  const BestSellTileCustom({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(   callBack: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  const SeeAllScreen(),
            ));
      },
      bgColor: Colors.grey.shade200,
      // shadow: [
      //   BoxShadow(
      //       color: greycolor.withOpacity(.3),
      //       spreadRadius: 1.sp,
      //       blurRadius: 1.sp,
      //       offset: const Offset(0, 4)),
      // ],
      width: 180.w,
      // border: Border.all(
      //   color: greycolor.withOpacity(.4),
      // ),
      borderRadius: BorderRadius.circular(8.r),
      marginLeft: 10.w,
      marginTop: 10.h,
      marginBottom: 15.h,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: ContainerCustom(
              bgColor: greycolor.withOpacity(.2),
              // height: 170.h,
              width: 180.w,
              child: Image.asset(
                imageUrl,
                width: 180.w,
                height: 250.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // TextCustomWidget(
          //   marginBottom: 15.h,
          //   containerAlignment: Alignment.bottomCenter,
          //   text: 'Tile Name',
          //   textStyle: GoogleFonts.aldrich(
          //       textStyle: Theme.of(context).textTheme.displayLarge,
          //       fontSize: 15.sp,
          //       fontWeight: FontWeight.w500,
          //       fontStyle: FontStyle.italic,
          //       color: Colors.black54),
          // )
        ],
      ),
    );
  }
}
