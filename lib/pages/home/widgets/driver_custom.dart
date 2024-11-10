import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_constant.dart';
import '../../../custom/widgets/container_custom.dart';

class DriverCustom extends StatelessWidget {
  const DriverCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(marginLeft: 15.w ,marginRight: 15.w,
      marginTop: 10.h,
      child:  Row(
        children: [
       const   Expanded(
            child: Divider(
              color: basecolor,
            ),
          ),Image.asset('asset/divider_img.png',height: 50.h,),
          // Icon(
          //   CupertinoIcons.checkmark_seal_fill,
          //   color: primaryColor,
          // ),
      const    Expanded(
            child: Divider(
              color: basecolor,
            ),
          )
        ],
      ),
    );
  }
}
