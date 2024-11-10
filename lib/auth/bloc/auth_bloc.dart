import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coar/core/add_or_update_document.dart';
import 'package:coar/root/root_page.dart';
import 'package:coar/service_locator/service_locator.dart';
import 'package:coar/services/auth_service.dart';
import 'package:coar/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/snackbar_service.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;

  const AuthState({required this.status, this.user});

  @override
  List<Object?> get props => [status, user];
}

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;
  final SnackBarService snackBarService = locator<SnackBarService>();

  AuthCubit(this._authService)
      : super(const AuthState(status: AuthStatus.initial)) {
    _authService.authStateChanges.listen((User? user) {
      if (user == null) {
        emit(const AuthState(status: AuthStatus.unauthenticated));
      } else {
        emit(AuthState(status: AuthStatus.authenticated, user: user));
      }
    });
  }
  Future<bool> loginFun(
      String email, String password, BuildContext context) async {
    try {
      // Handle login logic here
      await _authService.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const RootPage()),
        (Route<dynamic> route) => false,
      );
      return false;
    } catch (e) {
      // ignore: use_build_context_synchronously
      snackBarService.showError(e.toString(), context);
      return false;
    }
  }

  Future<bool> logout(BuildContext context) async {
    try {
      _authService.signUserOut().then(
            (value) => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const RootPage()),
              (Route<dynamic> route) => false,
            ),
          );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool?> forgotFun(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      // ignore: use_build_context_synchronously
      Navigator.pop(context);

      // ignore: use_build_context_synchronously
      snackBarService.showSuccess('A reset link sent to your e mail', context);
      return false;
    } catch (e) {
      // ignore: use_build_context_synchronously
      snackBarService.showError(e.toString(), context);
      return false;
    }
  }

  Future<bool> signupFun({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required BuildContext context,
  }) async {
    try {
      final newUserId = await _authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userModel = UserModel(
        id: newUserId,
        createdAt: Timestamp.now(),
        email: email,
        fName: fullName,
        updatedAt: Timestamp.now(),
        phoneNumber: phoneNumber,
        lName: '',
        isAdmin: false,
      );

      final params = AddOrUpdateDocumentParams(
        collectionName: 'users',
        data: userModel.toJson(),
        docId: newUserId,
      );
      var res = await addOrUpdateDocument(params);
      if (res.isRight()) {
        snackBarService.showSuccess('Signup successful', context);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const RootPage()),
          (Route<dynamic> route) => false,
        );
      }
      if (context.mounted) {
        res.fold(
          (error) {
            snackBarService.showError(error, context);
          },
          (success) {},
        );
      }

      return true;
    } catch (e) {
      if (context.mounted) {
        snackBarService.showError(e.toString(), context);
      }
      return false;
    }
  }
}
