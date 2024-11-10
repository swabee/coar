import 'package:coar/constants/app_constant.dart';
import 'package:coar/custom/widgets/container_custom.dart';
import 'package:coar/custom/widgets/text_custom.dart';
import 'package:coar/pages/home/admin_home/bloc/product_cubit/product_cubit.dart';
import 'package:coar/pages/see_all/product_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List<String> imgeUrl = [
    //   'asset/neckls.jpg',
    //   'asset/photo_6181421562557742508_x.jpg',
    //   'asset/photo_6181421562557742509_x.jpg',
    //   'asset/photo_6181421562557742510_x.jpg',
    //   'asset/photo_6181421562557742511_x.jpg',
    //   'asset/photo_6181421562557742513_x.jpg'
    // ];
    // List<String> realPrize = [
    //   '32000',
    //   '13000',
    //   '24500',
    //   '54000',
    //   '34000',
    //   '36000'
    // ];
    // List<String> offerPrize = [
    //   '30000',
    //   '12000',
    //   '21500',
    //   '52000',
    //   '32500',
    //   '31500'
    // ];
    // List<String> description = [
    //   'Sparkiling simplicity Manglasutra',
    //   'New life with your patner',
    //   '22 Cr gold bangle',
    //   'Simple Maglasutra with attractive design',
    //   'Classic design Manglasutra',
    //   'Sparkiling simplicity Manglasutra',
    // ];
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            backgroundColor: basecolor,
            leading: Text(''),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ContainerCustom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                  bgColor: basecolor,
                  width: double.infinity,
                  height: 40.h,
                  child: CupertinoTextField(
                    prefix: ContainerCustom(
                      marginLeft: 10.w,
                      marginRight: 15.w,
                      child: Icon(
                        CupertinoIcons.search,
                        color: primaryColor,
                        size: 17.sp,
                      ),
                    ),
                    placeholder: 'search for jewellery on coar',
                  ),
                ),
                ContainerCustom(
                  marginTop: 10.h,
                  marginLeft: 10.w,
                  marginRight: 10.w,
                  width: double.infinity,
                  height: 725.h,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 15.0,
                      childAspectRatio: .68,
                    ),
                    itemBuilder: (context, index) {
                      return ProductTile(
                        productModel: state.productList[index],
                      );
                    },
                    itemCount: state.productList.length, // Number of items in the grid
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: ContainerCustom(
            width: double.infinity,
            bgColor: primaryColor,
            height: 50.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ContainerCustom(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                      TextCustomWidget(
                        text: 'Filter',
                        textColor: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ],
                  ),
                ),
                ContainerCustom(
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.sort_down,
                        color: Colors.white,
                      ),
                      TextCustomWidget(
                        text: 'Sort',
                        textColor: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ],
                  ),
                ),
                ContainerCustom(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.list,
                        color: Colors.white,
                      ),
                      TextCustomWidget(
                        text: 'List',
                        textColor: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
