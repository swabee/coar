import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String fName;
  final String lName;
  final String? phoneNumber;
  final bool isAdmin;

  final Timestamp createdAt;
  final Timestamp updatedAt;
  const UserModel({
    required this.id,
    required this.email,
    required this.fName,
    required this.lName,
    this.isAdmin = false,
    required this.createdAt,
    required this.updatedAt,
    this.phoneNumber,
  });

  @override
  List<Object?> get props =>
      [id, email, fName, lName, phoneNumber, createdAt, updatedAt, isAdmin];

  UserModel copyWith({
    String? id,
    String? email,
    String? fName,
    String? lName,
    String? phoneNumber,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    bool? isAdmin,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fName: fName ?? this.fName,
      lName: lName ?? this.lName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static UserModel get empty => UserModel(
      id: '',
      email: '',
      fName: '',
      lName: '',
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
      isAdmin: false);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': fName,
      'last_name': lName,
      'phone_number': phoneNumber,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_admin': isAdmin
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fName: json['first_name'],
      lName: json['last_name'],
      phoneNumber: json['phone_number'] as String?,
      createdAt: json['created_at'] as Timestamp,
      updatedAt: json['updated_at'] as Timestamp,
      isAdmin: json['is_admin'] as bool,
    );
  }
}
