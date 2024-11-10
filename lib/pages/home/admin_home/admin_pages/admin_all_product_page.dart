import 'package:coar/constants/app_constant.dart';
import 'package:coar/custom/widgets/container_custom.dart';
import 'package:coar/custom/widgets/text_custom.dart';
import 'package:coar/pages/home/admin_home/admin_pages/add_new_product_age.dart';
import 'package:coar/pages/home/admin_home/bloc/product_cubit/product_cubit.dart';
import 'package:coar/pages/home/admin_widgets/admin_product_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminAllProductPage extends StatefulWidget {
  const AdminAllProductPage({super.key});

  @override
  State<AdminAllProductPage> createState() => _AdminAllProductPageState();
}

List<String> imgeUrl = [
  'asset/neckls.jpg',
  'asset/photo_6181421562557742508_x.jpg',
  'asset/photo_6181421562557742509_x.jpg',
  'asset/photo_6181421562557742510_x.jpg',
  'asset/photo_6181421562557742511_x.jpg',
  'asset/photo_6181421562557742513_x.jpg'
];
List<String> realPrize = ['32000', '13000', '24500', '54000', '34000', '36000'];
List<String> offerPrize = [
  '30000',
  '12000',
  '21500',
  '52000',
  '32500',
  '31500'
];
List<String> description = [
  'Sparkiling simplicity Manglasutra',
  'New life with your patner',
  '22 Cr gold bangle',
  'Simple Maglasutra with attractive design',
  'Classic design Manglasutra',
  'Sparkiling simplicity Manglasutra',
];

class _AdminAllProductPageState extends State<AdminAllProductPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            backgroundColor: whiteColor,
            elevation: 2,
            shadowColor: greycolor,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CupertinoIcons.back)),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ContainerCustom(
                  callBack: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProductPage(),
                        ));
                  },
                  borderRadius: BorderRadius.circular(122.r),
                  marginBottom: 10.h,
                  marginTop: 20.h,
                  bgColor: primaryColor,
                  height: 40.h,
                  width: 160.w,
                  child: TextCustomWidget(
                    containerAlignment: Alignment.center,
                    text: 'Add new Product',
                    textColor: whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ContainerCustom(
                  marginTop: 10.h,
                  marginLeft: 10.w,
                  marginRight: 10.w,
                  width: double.infinity,
                  height: 825.h,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 15.0,
                      childAspectRatio: .68,
                    ),
                    itemBuilder: (context, index) {
                      return AdminProductTile(
                        productModel: state.productList[index],
                      );
                    },
                    itemCount: state.productList.length,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
