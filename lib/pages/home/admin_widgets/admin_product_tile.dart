import 'package:coar/constants/app_constant.dart';
import 'package:coar/custom/widgets/container_custom.dart';
import 'package:coar/custom/widgets/text_custom.dart';
import 'package:coar/model/prodcut_model.dart';
import 'package:coar/pages/home/admin_home/bloc/product_cubit/product_cubit.dart';
import 'package:coar/pages/see_all/product_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminProductTile extends StatelessWidget {
  final ProductModel productModel;
  const AdminProductTile({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerCustom(
      shadow: [
        BoxShadow(
            blurRadius: 2.sp,
            spreadRadius: 1.sp,
            color: greycolor.withOpacity(.3),
            offset: const Offset(0, 2))
      ],
      callBack: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ProductDetailScreen()));
      },
      bgColor: whiteColor,
      borderRadius: BorderRadius.circular(5.r),
      child: Column(
        children: [
          ContainerCustom(
            borderRadius: BorderRadius.circular(5.r),
            bgColor: basecolor,
            width: double.infinity,
            height: 200.h,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: Image.network(
                    productModel.imageUrl,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
                ContainerCustom(
                  height: 40.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: Center(
                      //       child: Icon(
                      //         CupertinoIcons.video_camera,
                      //         size: 20.sp,
                      //         color: primaryColor,
                      //       ),
                      //     )),
                      ContainerCustom(
                        callBack: () {},
                        width: 40.h,
                        height: 40.h,
                        borderRadius: BorderRadius.circular(50.r),
                        bgColor: whiteColor,
                        // padding: EdgeInsets.all(8.sp),
                        child: Center(
                          child: IconButton(
                              onPressed: () {
                                context.read<ProductsCubit>().deleteProduct(
                                    productModel.id, productModel.imageUrl);
                              },
                              icon: Center(
                                child: Icon(
                                  CupertinoIcons.delete,
                                  size: 16.sp,
                                  color: primaryColor,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              TextCustomWidget(
                marginTop: 12.h,
                marginLeft: 10.w,
                text: '₹ ${productModel.offerPrice}',
                textStyle: GoogleFonts.aBeeZee(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    color: primaryColor),
              ),
              TextCustomWidget(
                marginTop: 12.h,
                marginLeft: 10.w,
                text: '₹ ${productModel.actualPrice}',
                textStyle: GoogleFonts.aBeeZee(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: greycolor,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          TextCustomWidget(
            marginTop: 7.h,
            marginLeft: 10.w,
            text: productModel.name,
            textStyle: GoogleFonts.playfairDisplay(
                // textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                // fontStyle: FontStyle.italic,
                color: greycolor),
          ),
        ],
      ),
    );
  }
}
