
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:coar/services/auth_service.dart';
import 'package:coar/services/snackbar_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  //! Firebase Auth
  registerLazySingleton<FirebaseAuth>(FirebaseAuth.instance);

  //! Firebase Firestore
  registerLazySingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  // FirebaseFirestore.instance.clearPersistence();

  //! Firebase Real Time Database
  registerLazySingleton<FirebaseDatabase>(FirebaseDatabase.instance);

  //! Firebase Functions
  registerLazySingleton<FirebaseFunctions>(FirebaseFunctions.instance);

  //! Firebase Analytics
  registerLazySingleton<FirebaseAnalytics>(FirebaseAnalytics.instance);

  //! Firebase messaging
  registerLazySingleton<FirebaseMessaging>(FirebaseMessaging.instance);

  //! Firebase Storage
  registerLazySingleton<FirebaseStorage>(FirebaseStorage.instance);

  //! Crashlytics
  registerLazySingleton<FirebaseCrashlytics>(FirebaseCrashlytics.instance);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  //! Auth service
  locator.registerLazySingleton(() => AuthService());

  //! Local storage
  // locator.registerLazySingleton(() => LocalStorage());
  // locator.registerLazySingleton(() => LocationService());

  //! Snackbar service
  locator.registerLazySingleton(() => SnackBarService());
}

void registerLazySingleton<T extends Object>(T object) {
  return locator.registerLazySingleton<T>(() => object);
}
