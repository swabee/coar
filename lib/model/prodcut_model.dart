import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double actualPrice;
  final double offerPrice;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.actualPrice,
    required this.offerPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        actualPrice,
        offerPrice,
        createdAt,
        updatedAt,
      ];

  // CopyWith method for immutability
  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    double? actualPrice,
    double? offerPrice,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      actualPrice: actualPrice ?? this.actualPrice,
      offerPrice: offerPrice ?? this.offerPrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'actual_price': actualPrice,
      'offer_price': offerPrice,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // JSON deserialization
  static ProductModel fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      actualPrice: (json['actual_price'] as num).toDouble(),
      offerPrice: (json['offer_price'] as num).toDouble(),
      createdAt: json['created_at'] as Timestamp,
      updatedAt: json['updated_at'] as Timestamp,
    );
  }

  // Empty instance for initial state
  static ProductModel get empty => ProductModel(
        id: '',
        name: '',
        description: '',
        imageUrl: '',
        actualPrice: 0.0,
        offerPrice: 0.0,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );
}
