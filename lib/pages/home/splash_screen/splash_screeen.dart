import 'package:coar/constants/app_constant.dart';
import 'package:coar/custom/widgets/container_custom.dart';
import 'package:coar/features/user_detail_cubit.dart';
import 'package:coar/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreeen extends StatefulWidget {
  const SplashScreeen({super.key});

  @override
  State<SplashScreeen> createState() => _SplashScreeenState();
}

class _SplashScreeenState extends State<SplashScreeen> {
  @override
  void initState() {
    gotoNext();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsCubit, UserDetailsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: whiteColor,
          body: ContainerCustom(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //         ClipRRect(
                //   borderRadius: BorderRadius.circular(200.sp),
                //   child: Image.asset(
                //     'asset/cor..jpg',
                //     height: MediaQuery.of(context).size.height * .3,
                //     width: MediaQuery.of(context).size.height * .3,
                //     fit: BoxFit.cover,
                //     // fit: BoxFit.fitHeight,
                //   ),
                // ),
                Image.asset(
                  'asset/cor..jpg',
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.height * .3,
                  fit: BoxFit.cover,
                  // fit: BoxFit.fitHeight,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> gotoNext() async {
  
    await Future.delayed(const Duration(seconds: 2));

    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) => false,
    );
  }
}
