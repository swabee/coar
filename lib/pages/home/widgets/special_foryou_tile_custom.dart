import 'package:coar/constants/app_constant.dart';
import 'package:coar/pages/see_all/see_all_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../custom/widgets/container_custom.dart';
import '../../../custom/widgets/text_custom.dart';

class SpecialForyouTileCustom extends StatelessWidget {
  final String imageUrl;
  const SpecialForyouTileCustom({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(   callBack: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  const SeeAllScreen(),
            ));
      },
      width: 150.w,
      height: 160.h,
      border: Border.all(
        color: greycolor.withOpacity(.4),
      ),
      borderRadius: BorderRadius.circular(8.r),
      marginLeft: 25.w,
      marginTop: 20.h,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r), topRight: Radius.circular(8.r)),
            child: ContainerCustom(
              bgColor: greycolor.withOpacity(.2),
              height: 170.h,
              width: 150.w,
              child: Image.asset(
                imageUrl,
                height: 170.h,
                width: 150.w,fit: BoxFit.cover,
              ),
            ),
          ),
          TextCustomWidget(marginTop: 10.h,
            containerAlignment: Alignment.center,
            text: 'Explore', 
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            textColor: primaryColor,
          )
        ],
      ),
    );
  }
}
