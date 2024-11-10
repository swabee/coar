// // Step 1: Import necessary packages
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coar/backend/storage_service.dart';
import 'package:coar/service_locator/service_locator.dart';
import 'package:coar/services/auth_service.dart';
import 'package:coar/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// Step 2: Create a new class for the User Details state
class UserDetailsState extends Equatable {
  final UserModel userDetails;

  const UserDetailsState(this.userDetails);

  @override
  List<Object?> get props => [userDetails];

  UserDetailsState copyWith({
    UserModel? userDetails,
  }) {
    return UserDetailsState(
      userDetails ?? this.userDetails,
    );
  }
}

// Step 3: Create a new class for the User Details cubit
class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit() : super(UserDetailsState(UserModel.empty)) {
    // Step 6: Listen to the current user stream
    _currentUserSubscription =
        _authService.authStateChanges.listen((currentUser) {
      if (currentUser != null) {
        _detailStreamSubscription?.cancel();
        _detailStreamSubscription =
            getUserDetailsStream(currentUser.uid).listen((event) {
          emit(state.copyWith(userDetails: event));
        });
      } else {
        _detailStreamSubscription?.cancel();
      }
    });
  }
  final FirebaseFirestore _firestore = locator<FirebaseFirestore>();
  late StreamSubscription<User?> _currentUserSubscription;
  StreamSubscription<UserModel>? _detailStreamSubscription;
  final AuthService _authService = locator<AuthService>();
  final StorageService storageService = StorageService();
  final FirebaseFirestore firebaseFirestore = locator<FirebaseFirestore>();

  // Step 4: Define a method to fetch user details from Firestore
  Stream<UserModel> getUserDetailsStream(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map((event) =>
        event.exists ? UserModel.fromJson(event.data()!) : UserModel.empty);
  }

  // Future<String?> uploadtoSotrage(
  //   File imageFiles,
  //   String userName,
  // ) async {
  //   final imageUrl = await storageService.uploadFileToFirebase(
  //       imageFiles, "users/$userName/profile/${imageFiles.path}");
  //   return imageUrl;
  // }

  // Future<Either<String, Unit>> updatePrfile(
  //     UserModel userModel, File? imageFile) async {
  //   try {
  //     if (imageFile != null) {
  //       final imgUrl = await uploadtoSotrage(imageFile, userModel.id);
  //       var newUser = userModel.copyWith(profilePictureUrl: imgUrl);
  //       //
  //       firebaseFirestore
  //           .collection(FirebaseConstants.usersCollectionName)
  //           .doc(userModel.id)
  //           .set(newUser.toJson());
  //     } else if (imageFile == null) {
  //       //
  //       firebaseFirestore
  //           .collection(FirebaseConstants.productsCollection)
  //           .doc(userModel.id)
  //           .set(userModel.toJson());
  //     }
  //     return right(unit);
  //   } catch (e) {
  //     return left(e.toString());
  //   }
  // }

  @override
  Future<void> close() {
    _detailStreamSubscription?.cancel();
    _currentUserSubscription.cancel();
    return super.close();
  }
}
