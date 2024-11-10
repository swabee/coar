import 'package:coar/constant/firebse_constants.dart';
import 'package:coar/constants/app_constant.dart';
import 'package:coar/custom/container_custom.dart';
import 'package:coar/custom/text_custom.dart';
import 'package:coar/pages/home/admin_home/bloc/all_users/all_user_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminAllUsersPage extends StatelessWidget {
  const AdminAllUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllUsersCubit, AllUsersState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            shadowColor: Colors.grey.shade300,
            elevation: 2.sp,
            backgroundColor: whiteColor,
            leading: Text(''),
          ),
          body: ListView.builder(
            itemCount: state.userList.length,
            itemBuilder: (context, index) {
              return ContainerCustom(
                marginTop: 20.h,
                // marginBottom: 20.h,
                bgColor: whiteColor,
                shadow: [
                  // BoxShadow(
                  //     color: basecolor,
                  //     spreadRadius: 1.sp,
                  //     blurRadius: 2.sp,
                  //     offset: Offset(4, 4))
                ],
                borderRadius: BorderRadius.circular(6.r),
                marginRight: 15.w,
                marginLeft: 20.w,
                border: Border.all(color: Colors.grey.shade300),
                height: 60.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(CupertinoIcons.person),
                    // Image.asset('asset/photo_6181421562557742513_x.jpg'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextCustomWidget(
                          marginTop: 10.h,
                          marginLeft: 10.w,

                          text: state.userList[index].fName,
                          containerAlignment: Alignment.centerLeft,
                          fontSize: 13.sp,
                          textColor: Colors.grey,
                          // fontWeight: FontWeight.bold,
                        ),
                        TextCustomWidget(
                          marginLeft: 10.w,

                          text: "join on " +defaultDateOnlyFormat
                              .format(state.userList[index].createdAt.toDate()),
                          containerAlignment: Alignment.centerLeft,
                          fontSize: 13.sp,
                          textColor: Colors.grey,
                          // fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40.w,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.phone,
                          color: primaryColor,
                        ))
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
