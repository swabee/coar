import 'package:coar/pages/see_all/see_all_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../custom/widgets/container_custom.dart';

class HomeCateogryTileCustom extends StatelessWidget {
  final String imageUrl;
  const HomeCateogryTileCustom({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      callBack: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  const SeeAllScreen(),
            ));
      },
      marginLeft: 25.w,
      marginTop: 20.h,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40.r,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40.r),
              child: Image.asset(imageUrl),
            ),
          ),
          // TextCustomWidget(
          //   text: 'Tile Name',
          //   fontSize: 11.sp,
          //   fontWeight: FontWeight.w400,
          //   textColor: Colors.grey,
          // )
        ],
      ),
    );
  }
}
