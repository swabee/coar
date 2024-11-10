import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coar/model/prodcut_model.dart';
import 'package:coar/service_locator/service_locator.dart';
import 'package:coar/services/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum Status { loading, loaded, error }

class ProductsState extends Equatable {
  final List<ProductModel> productList;
  final List<String> categoryList;
  final Status status;

  const ProductsState({
    required this.productList,
    required this.categoryList,
    this.status = Status.loading,
  });

  @override
  List<Object?> get props => [productList, categoryList, status];

  ProductsState copyWith({
    List<ProductModel>? productList,
    List<String>? categoryList,
    Status? status,
  }) {
    return ProductsState(
      productList: productList ?? this.productList,
      categoryList: categoryList ?? this.categoryList,
      status: status ?? this.status,
    );
  }
}

class ProductsCubit extends Cubit<ProductsState> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final AuthService _authService = locator<AuthService>();

  ProductsCubit()
      : super(const ProductsState(productList: [], categoryList: []));

  Future<void> fetchProducts() async {
    try {
      emit(state.copyWith(status: Status.loading));
      final productSnapshot = await _firebaseFirestore
          .collection('products')
          .orderBy('created_at', descending: true)
          .get();

      final products = productSnapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();

      emit(state.copyWith(productList: products, status: Status.loaded));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> addProduct(ProductModel product, File imageFile) async {
    try {
      emit(state.copyWith(status: Status.loading));

      // Upload the image to Firebase Storage
      String imageUrl = await _uploadImage(imageFile);

      // Add the product to Firestore
      final docRef = _firebaseFirestore.collection('products').doc();

      final newProduct = product.copyWith(
        id: docRef.id,
        imageUrl: imageUrl,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

      await docRef.set(newProduct.toJson());

      // Fetch updated product list after adding the new product
      fetchProducts();
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<void> deleteProduct(String productId, String imageUrl) async {
    try {
      // Delete the product document from Firestore
      await _firebaseFirestore.collection('products').doc(productId).delete();

      // Delete the image from Firebase Storage
      if (imageUrl.isNotEmpty) {
        await _firebaseStorage.refFromURL(imageUrl).delete();
      }

      // Remove the deleted product from the state
      List<ProductModel> updatedList = List.from(state.productList)
        ..removeWhere((product) => product.id == productId);
      emit(state.copyWith(productList: updatedList, status: Status.loaded));
    } catch (e) {
      emit(state.copyWith(status: Status.error));
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = _firebaseStorage.ref().child('product_images/$fileName');
      final uploadTask = await ref.putFile(imageFile);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      throw Exception("Image upload failed");
    }
  }
}
