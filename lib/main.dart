import 'package:coar/auth/bloc/auth_bloc.dart';
import 'package:coar/backend/firebase_options.dart';
import 'package:coar/features/user_detail_cubit.dart';
import 'package:coar/pages/home/admin_home/bloc/all_users/all_user_cubit.dart';
import 'package:coar/pages/home/admin_home/bloc/product_cubit/product_cubit.dart';
import 'package:coar/root/root_page.dart';
import 'package:coar/service_locator/service_locator.dart';
import 'package:coar/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 920),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthCubit(
                locator<AuthService>(),
              ),
            ),
            BlocProvider(
              create: (context) => UserDetailsCubit(),
            ),  
                 BlocProvider(
              create: (context) => AllUsersCubit(),
            ),
                  BlocProvider(
              create: (context) => ProductsCubit(),
            ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: RootPage(),
        ),
      ),
    );
  }
}
