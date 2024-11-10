import 'package:coar/auth/bloc/auth_bloc.dart';
import 'package:coar/constant/app_constants.dart';
import 'package:coar/constants/app_constant.dart';
import 'package:coar/custom/button_custom.dart';
import 'package:coar/custom/iconbutton_custom.dart';
import 'package:coar/custom/textfield_custom.dart';
import 'package:coar/custom/widgets/text_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  bool inProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustomWidget(
                marginTop: 234.h,
                text: "Signup",
                fontSize: 40.sp,
                fontWeight: FontWeight.w600,
              ),
              TextCustomWidget(
                text: "Create your account and get started",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                textColor: neutrals8,
              ),
              TextCustomWidget(
                marginTop: 32.h,
                text: "Email",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              TextFieldCustom(
                controller: emailController,
                useUnderlineBorder: true,
                borderColor: neutrals7,
                hintText: "Enter Your Email",
                cphorizontal: 0,
                keyboardType: TextInputType.emailAddress,
              ),
              TextCustomWidget(
                marginTop: 24.h,
                text: "Password",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              TextFieldCustom(
                controller: passwordController,
                useUnderlineBorder: true,
                borderColor: neutrals7,
                hintText: "Enter Password",
                cphorizontal: 0,
                suffixIcon: Icon(CupertinoIcons.eye),
              ),
              TextCustomWidget(
                marginTop: 24.h,
                text: "Confirm Password",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              TextFieldCustom(
                controller: passwordConfirmController,
                useUnderlineBorder: true,
                borderColor: neutrals7,
                hintText: "Enter Password",
                cphorizontal: 0,
                suffixIcon: Icon(CupertinoIcons.eye),
              ),
              SizedBox(height: 32.h),
              ButtonCustom(
                textStyle: TextStyle(
                    color: whiteColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold),
                btnColor: Color.fromARGB(255, 182, 65, 115),
                inProgress: inProgress,
                text: "Sign up",
                callback: () async {
                  if (passwordConfirmController.text ==
                      passwordController.text) {
                    setState(() {
                      inProgress = true;
                    });
                    var res = await context.read<AuthCubit>().signupFun(
                        email: emailController.text,
                        password: passwordController.text,
                        fullName: emailController.text,
                        phoneNumber: '',
                        context: context);
                    setState(() {
                      inProgress = res;
                    });
                  }
                  // Navigator.pushNamed(context, homeRoute);
                },
                dontApplyMargin: true,
              ),
              SizedBox(
                height: 120.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextCustomWidget(
                    text: "Already have an account ?",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  IconButtonCustom(
                    // btnWidth: 50.w,
                    dontApplyMargin: true,
                    callback: () {
                      Navigator.pop(context);
                    },
                    child: TextCustomWidget(
                      text: "Login",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
