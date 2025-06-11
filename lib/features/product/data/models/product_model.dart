import 'package:thuongmaidientu/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.productId,
    required super.cover,
    required super.storeId,
    required super.categoryId,
    required super.productName,
    required super.description,
    required super.createdAt,
    required super.updatedAt,
    required super.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'],
      cover: json['cover'],
      storeId: json['storeId'], // Nested store object
      categoryId: json['categoryId'],
      productName: json['productName'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'store': {'storeId': storeId},
      'category': {'categoryId': categoryId},
      'productName': productName,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'price': price,
    };
  }
}
