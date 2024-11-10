import 'package:coar/constants/app_constant.dart';
import 'package:coar/custom/widgets/container_custom.dart';
import 'package:coar/custom/widgets/rating_star_custom.dart';
import 'package:coar/custom/widgets/text_custom.dart';
import 'package:coar/pages/home/widgets/safe_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: basecolor,
        leading: Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ContainerCustom(
              marginTop: 15.h,
              marginRight: 20.w,
              marginLeft: 20.w,
              height: 290.h,
              child: Stack(
                children: [
                  ContainerCustom(
                    marginTop: 10.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.r),
                      child: Image.asset(
                        'asset/neckls.jpg',
                        height: 390.h,
                        width: 350.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  ContainerCustom(
                    callBack: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => PlayTutorialScreen(),
                      //     ));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CameraScreen(),
                          ));
                    },
                    width: 90.w,
                    padding: EdgeInsets.symmetric(horizontal: 6.sp),
                    borderRadius: BorderRadius.circular(40.sp),
                    bgColor: basecolor,
                    height: 35.h,
                    // width: 60.w,
                    child: Row(
                      children: [
                        TextCustomWidget(
                          textColor: primaryColor,
                          marginRight: 5.w,
                          fontSize: 12.sp,
                          text: 'Try now',
                          containerAlignment: Alignment.center,
                        ),
                        Icon(
                          CupertinoIcons.video_camera,
                          size: 19.sp,
                          color: primaryColor,
                        )
                      ],
                    ),
                  )
                  // IconButton(
                  //     onPressed: ()async {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) =>  const CameraScreen(),
                  //     ));
                  //     },
                  // icon: Icon(
                  //   CupertinoIcons.video_camera,
                  //   size: 30.sp,
                  //   color: primaryColor,
                  // ))
                ],
              ),
            ),
            ContainerCustom(
              marginTop: 10.h,
              marginLeft: 20.w,
              height: 100.h,
              child: Row(
                children: [
                  ContainerCustom(
                    height: 90.h,
                    width: 90.h,
                    child: Image.asset(
                      'asset/neckls.jpg',
                    ),
                  ),
                  ContainerCustom(
                    height: 90.h,
                    width: 90.h,
                    child: Image.asset(
                      'asset/neckls.jpg',
                    ),
                  ),
                  ContainerCustom(
                    height: 90.h,
                    width: 90.h,
                    child: Image.asset(
                      'asset/neckls.jpg',
                    ),
                  ),
                ],
              ),
            ),
            TextCustomWidget(
              marginTop: 10.h,
              marginLeft: 20.w,
              text: appname,
              textStyle: GoogleFonts.playfairDisplay(
                  // textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w400,
                  // fontStyle: FontStyle.italic,
                  color: primaryColor),
            ),
            TextCustomWidget(
              marginTop: 10.h,
              marginLeft: 20.w,
              text: 'Bloom ing Love Diamond Mangalsutra',
              textStyle: GoogleFonts.playfairDisplay(
                  // textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  // fontStyle: FontStyle.italic,
                  color: greycolor),
            ),
            ContainerCustom(
              marginLeft: 20.w,
              alignment: Alignment.centerLeft,
              marginTop: 10.h,
              child: const RatingStars(rating: 4.5),
            ),
            TextCustomWidget(
              marginTop: 15.h,
              marginLeft: 20.w,
              text: '₹43000',
              textStyle: GoogleFonts.notoSansSc(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: primaryColor),
            ),
            TextCustomWidget(
              marginTop: 5.h,
              marginLeft: 20.w,
              text: 'Including all tax',
              textStyle: GoogleFonts.playfairDisplay(
                  // textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  // fontStyle: FontStyle.italic,
                  color: greycolor),
            ),
            TextCustomWidget(
              marginTop: 15.h,
              marginLeft: 20.w,
              text: 'Size  & Gross Weight',
              textStyle: GoogleFonts.playfairDisplay(
                  // textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  // fontStyle: FontStyle.italic,
                  color: Colors.black),
            ),
            TextCustomWidget(
              marginRight: 10.w,
              marginTop: 15.h,
              marginLeft: 20.w,
              text:
                  'weight and price of the jewellery item may vary subject to the stock available',
              textStyle: GoogleFonts.playfairDisplay(
                  // textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  // fontStyle: FontStyle.italic,
                  color: greycolor),
            ),
            Row(
              children: [
                TextCustomWidget(
                  marginTop: 15.h,
                  marginLeft: 20.w,
                  text: 'Size',
                  textStyle: GoogleFonts.playfairDisplay(
                      // textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      // fontStyle: FontStyle.italic,
                      color: Colors.black),
                ),
                TextCustomWidget(
                  marginTop: 15.h,
                  marginLeft: 5.w,
                  text: '(in Inch)',
                  textStyle: GoogleFonts.playfairDisplay(
                      // textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      // fontStyle: FontStyle.italic,
                      color: greycolor),
                ),
              ],
            ),
            Row(
              children: [
                ContainerCustom(
                  marginTop: 10.h,
                  marginLeft: 20.w,
                  alignment: Alignment.centerLeft,
                  borderRadius: BorderRadius.circular(4.r),
                  bgColor: basecolor,
                  height: 30.h,
                  width: 60.w,
                  child: TextCustomWidget(
                    textColor: primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    text: '16',
                    containerAlignment: Alignment.center,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                TextCustomWidget(
                  marginTop: 15.h,
                  marginLeft: 20.w,
                  text: 'Weight',
                  textStyle: GoogleFonts.playfairDisplay(
                      // textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      // fontStyle: FontStyle.italic,
                      color: blackColor),
                ),
                TextCustomWidget(
                  marginTop: 15.h,
                  marginLeft: 5.w,
                  text: '(in IGms)',
                  textStyle: GoogleFonts.playfairDisplay(
                      // textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      // fontStyle: FontStyle.italic,
                      color: greycolor),
                ),
              ],
            ),
            Row(
              children: [
                ContainerCustom(
                  marginTop: 10.h,
                  marginLeft: 20.w,
                  alignment: Alignment.centerLeft,
                  borderRadius: BorderRadius.circular(4.r),
                  bgColor: basecolor,
                  height: 30.h,
                  width: 60.w,
                  child: TextCustomWidget(
                    textColor: primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    text: '4.13',
                    containerAlignment: Alignment.center,
                  ),
                ),
              ],
            ),
            TextCustomWidget(
              marginTop: 15.h,
              marginLeft: 20.w,
              text: 'Styling',
              textStyle: GoogleFonts.playfairDisplay(
                  // textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  // fontStyle: FontStyle.italic,
                  color: blackColor),
            ),
            TextCustomWidget(
              marginRight: 10.w,
              marginTop: 15.h,
              marginLeft: 20.w,
              text:
                  'Wear the mark of your expression love every day with this mangalsutra, crafted in 18 karat rose gold, studded with diamonds Stone Clarity l1/12',
              textStyle: GoogleFonts.playfairDisplay(
                  // textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  // fontStyle: FontStyle.italic,
                  color: greycolor),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      bottomNavigationBar: ContainerCustom(
        height: 70.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ContainerCustom(
              callBack: () {},
              bgColor: Colors.white,
              shadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: 3.r,
                    blurRadius: 3.sp,
                    offset: const Offset(2, 4))
              ],
              borderRadius: BorderRadius.circular(5.r),
              marginLeft: 10.w,
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              height: 50.h,
              border: Border.all(color: primaryColor, width: 2.sp),
              child: TextCustomWidget(
                text: 'Add to cart',
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                textColor: primaryColor,
              ),
            ),
            ContainerCustom(
              callBack: () {},
              bgColor: primaryColor,
              shadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: 3.r,
                    blurRadius: 3.sp,
                    offset: const Offset(2, 4))
              ],
              borderRadius: BorderRadius.circular(5.r),
              marginLeft: 10.w,
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              height: 50.h,
              border: Border.all(color: primaryColor, width: 2.sp),
              child: TextCustomWidget(
                text: 'Book Now',
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                textColor: whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
