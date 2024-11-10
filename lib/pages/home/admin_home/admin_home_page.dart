import 'package:coar/auth/bloc/auth_bloc.dart';
import 'package:coar/constants/app_constant.dart';
import 'package:coar/custom/container_custom.dart';
import 'package:coar/custom/text_custom.dart';
import 'package:coar/features/user_detail_cubit.dart';
import 'package:coar/pages/home/admin_home/admin_pages/admin_all_product_page.dart';
import 'package:coar/pages/home/admin_home/admin_pages/admin_all_users_page.dart';
import 'package:coar/pages/home/admin_home/bloc/all_users/all_user_cubit.dart';
import 'package:coar/pages/home/admin_home/bloc/product_cubit/product_cubit.dart';
import 'package:coar/pages/home/admin_widgets/booking_tile.dart';
import 'package:coar/pages/home/admin_widgets/dash_count_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsCubit, UserDetailsState>(
      builder: (context, userstate) {
        return BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, productstate) {
            return BlocBuilder<AllUsersCubit, AllUsersState>(
              builder: (context, alluserstate) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    shadowColor: basecolor,
                    elevation: 2.sp,
                    surfaceTintColor: whiteColor,
                    iconTheme: IconThemeData(color: primaryColor, size: 30.sp),
                    backgroundColor: whiteColor,
                    title: Row(
                      children: [
                        Image.asset(
                          'asset/cor..jpg',
                          height: 90.h,
                          width: 100.w,
                          fit: BoxFit.cover,
                        )
                      ],
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            context.read<AuthCubit>().logout(context);
                          },
                          icon: Icon(
                            CupertinoIcons.power,
                            size: 20.sp,
                          )),
                      SizedBox(
                        width: 10.w,
                      )
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextCustomWidget(
                          marginTop: 20.h,
                          marginLeft: 20.w,
                          // width: 150.w,
                          text: 'Welcome ' + userstate.userDetails.fName,
                          fontSize: 16.sp,
                          textColor: primaryColor,
                        ),
                        ContainerCustom(
                          marginLeft: 20.w,
                          marginTop: 20.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DashCountTile(
                                voidCallback: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AdminAllUsersPage(),
                                      ));
                                },
                                tileCOunt:
                                    alluserstate.userList.length.toString(),
                                tileName: 'Total User',
                              ),
                              DashCountTile(
                                voidCallback: () {},
                                tileCOunt: '3',
                                tileName: 'Total booking',
                              ),
                            ],
                          ),
                        ),
                        ContainerCustom(
                          marginLeft: 20.w,
                          marginTop: 20.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DashCountTile(
                                voidCallback: () {},
                                tileCOunt: '5',
                                tileName: 'Total Category',
                              ),
                              DashCountTile(
                                voidCallback: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AdminAllProductPage(),
                                      ));
                                },
                                tileCOunt:
                                    productstate.productList.length.toString(),
                                tileName: 'Total Products',
                              ),
                            ],
                          ),
                        ),
                        //today booking

                        TextCustomWidget(
                          marginLeft: 20.w,
                          marginTop: 30.h,
                          text: 'Today Booking',
                          containerAlignment: Alignment.centerLeft,
                          fontSize: 16.sp,
                          textColor: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        BookingTile(), BookingTile(), BookingTile(),
                        BookingTile(),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
