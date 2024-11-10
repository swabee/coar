
import 'package:coar/auth/bloc/auth_bloc.dart';
import 'package:coar/login/login.dart';
import 'package:coar/pages/home/splash_screen/splash_screeen.dart';
import 'package:coar/service_locator/service_locator.dart';
import 'package:coar/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = locator<AuthService>();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.user == null) {
          return const LoginPage();
        } else {
          return FutureBuilder(
            future: authService.getUserClaims(),
            builder: (BuildContext context, AsyncSnapshot claimsSnapshot) {
              if (claimsSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (claimsSnapshot.hasError) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Unexpected error"),
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Error: ${claimsSnapshot.error}'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            authService.signUserOut();
                          },
                          child: const Text("Logout"),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (claimsSnapshot.hasData) {
                // If user is authenticated and claims are available,
                // navigate to MyBaseScreen
                return const SplashScreeen();
              } else {
                return const Center(
                  child: Text('An error occurred'),
                );
              }
            },
          );
        }
      },
    );
  }
}
