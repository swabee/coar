import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coar/service_locator/service_locator.dart';
import 'package:coar/services/auth_service.dart';
import 'package:coar/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Status { loading, loaded, error }

class AllUsersState extends Equatable {
  final List<UserModel> guideList;
  final List<UserModel> userList;
  final List<UserModel> fetchedUsers;
  final Status status;

  const AllUsersState({
    required this.guideList,
    required this.userList,
    this.status = Status.loading,
    this.fetchedUsers = const [],
  });

  @override
  List<Object?> get props => [guideList, userList, status, fetchedUsers];

  // CopyWith method for immutability
  AllUsersState copyWith({
    List<UserModel>? guideList,
    List<UserModel>? userList,
    List<UserModel>? fetchedUsers,
    Status? status,
  }) {
    return AllUsersState(
      guideList: guideList ?? this.guideList,
      userList: userList ?? this.userList,
      fetchedUsers: fetchedUsers ?? this.fetchedUsers,
      status: status ?? this.status,
    );
  }
}
class AllUsersCubit extends Cubit<AllUsersState> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late StreamSubscription<User?> _currentUserSubscription;
  final AuthService _authService = locator<AuthService>();
  // final SnackBarService _snackBarService = locator<SnackBarService>();

  AllUsersCubit() : super(const AllUsersState(guideList: [], userList: [])) {
    emit(state.copyWith(status: Status.loading));

    _currentUserSubscription = _authService.authStateChanges.listen((currentUser) {
      if (currentUser != null) {
        fetchUsers();
      } else {
        emit(const AllUsersState(guideList: [], userList: []));
      }
    });
  }

  Future<void> fetchUsers() async {
    try {
      emit(state.copyWith(status: Status.loading));

      final currentUser = _authService.currentUser;
      if (currentUser != null) {
        // Fetch non-admin regular users
        final userSnapshot = await _firebaseFirestore
            .collection('users')
     
            .where('is_admin', isEqualTo: false)
            .where('id', isNotEqualTo: currentUser.uid)
            .limit(55)
            .get(GetOptions(source: Source.server));

        // Fetch non-admin guides
        final guideSnapshot = await _firebaseFirestore
            .collection('users')
            .where('is_admin', isEqualTo: false)
            .where('id', isNotEqualTo: currentUser.uid)
            .limit(55)
            .get(GetOptions(source: Source.server));

        final userList = userSnapshot.docs
            .map((doc) => UserModel.fromJson(doc.data()))
            .toList();

        final guideList = guideSnapshot.docs
            .map((doc) => UserModel.fromJson(doc.data()))
            .toList();

        emit(state.copyWith(
          userList: userList,
          guideList: guideList,
          status: Status.loaded,
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  // Future<void> rateThePerson(
  //     RatingModel ratingModel, String personId, BuildContext context) async {
  //   final docRef = _firebaseFirestore
  //       .collection(FirebaseConstants.usersCollectionName)
  //       .doc(personId)
  //       .collection(FirebaseConstants.ratingsCollection)
  //       .doc();

  //   var rating = RatingModel(
  //       id: docRef.id,
  //       dateCreated: Timestamp.now(),
  //       rating: ratingModel.rating,
  //       review: ratingModel.review,
  //       userId: _authService.currentUser!.uid);

  //   final params = AddOrUpdateDocumentParams(
  //       collectionName: FirebaseConstants.usersCollectionName,
  //       data: rating.toJson(),
  //       docId: personId,
  //       subCollectionName: FirebaseConstants.ratingsCollection,
  //       subDocId: docRef.id);

  //   var result = await addOrUpdateDocument(params);

  //   if (result.isRight()) {
  //     _snackBarService.showSuccess("Rating added", context);
  //     Navigator.pop(context);
  //   }
  // }

  UserModel getUserById(String userId) {
    try {
      return state.fetchedUsers.firstWhere(
        (user) => user.id == userId,
        orElse: () => UserModel.empty,
      );
    } catch (e) {
      print('Error finding user $userId: $e');
      return UserModel.empty;
    }
  }

  Future<UserModel> fetchUserDetails(String id) async {
    try {
      final value = await _firebaseFirestore.collection('users').doc(id).get();
      if (value.exists) {
        final newUser = UserModel.fromJson(value.data()!);
        List<UserModel> fetchedUsers = List.from(state.fetchedUsers);
        fetchedUsers.add(newUser);
        emit(state.copyWith(fetchedUsers: fetchedUsers));
        return newUser;
      } else {
        return UserModel.empty;
      }
    } catch (e) {
      return UserModel.empty;
    }
  }

  @override
  Future<void> close() {
    _currentUserSubscription.cancel();
    return super.close();
  }
}
