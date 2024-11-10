import 'package:coar/auth/bloc/auth_bloc.dart';
import 'package:coar/constant/app_constants.dart';
import 'package:coar/constants/app_constant.dart';
import 'package:coar/custom/button_custom.dart';
import 'package:coar/custom/iconbutton_custom.dart';
import 'package:coar/custom/textfield_custom.dart';
import 'package:coar/custom/widgets/text_custom.dart';
import 'package:coar/pages/signup/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool inProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 30.h, right: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustomWidget(
                marginTop: 234.h,
                text: "Login",
                fontSize: 40.sp,
                fontWeight: FontWeight.w600,
              ),
              TextCustomWidget(
                text: "Welcome Back user. Enter your details",
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
              // TextCustomWidget(
              //   marginTop: 24.h,
              //   text: "Confirm Password",
              //   fontSize: 14.sp,
              //   fontWeight: FontWeight.w500,
              // ),
              // TextFieldCustom(
              //   useUnderlineBorder: true,
              //   borderColor: neutrals7,
              //   hintText: "Enter Password",
              //   cphorizontal: 0,
              //   suffixIcon: Image(
              //     image: const AssetImage("assets/icons/eye.png"),
              //     width: 20.w,
              //     height: 20.h,
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButtonCustom(
                    margin: EdgeInsets.only(top: 16.h),
                    // btnWidth: 110.w,
                    btnHeight: 15.h,
                    dontApplyMargin: true,
                    callback: () {},
                    child: TextCustomWidget(
                      text: "Forgot password?",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      textDecoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              ButtonCustom(
                textStyle: TextStyle(
                    color: whiteColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold),
                btnColor: Color.fromARGB(255, 182, 65, 115),
                inProgress: inProgress,
                text: "Login",
                // isDisabled: false,
                callback: () async {
                  var res = await context.read<AuthCubit>().loginFun(
                      emailController.text, passwordController.text, context);
                  setState(() {
                    inProgress = res;
                  });
                },
                dontApplyMargin: true,
              ),
              SizedBox(
                height: 170.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextCustomWidget(
                    text: "Don’t have an account ?",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  IconButtonCustom(
                    // dontApplyMargin: true,
                    callback: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ));
                      // Navigator.pushNamed(context, signupRoute);
                    },
                    child: TextCustomWidget(
                      text: "Sign Up",
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
