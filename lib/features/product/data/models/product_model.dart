import 'package:thuongmaidientu/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
      {required super.productId,
      required super.cover,
      required super.storeId,
      required super.categoryId,
      required super.productName,
      required super.description,
      required super.createdAt,
      required super.updatedAt,
      required super.price,
      required super.avgRating,
      required super.totalSold});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        productId: json['product_id'],
        cover: json['cover'],
        storeId: json['store_id'], // Nested store object
        categoryId: json['category_id'],
        productName: json['product_name'],
        description: json['description'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        price: json['price'].toDouble(),
        avgRating: json['avg_rating'].toDouble(),
        totalSold: json['total_sold']);
  }

  Map<String, dynamic> toJson() {
    return {
      'product_idd': productId,
      'store': {'store_id': storeId},
      'category': {'category_id': categoryId},
      'productn_name': productName,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'price': price,
      'total_sold': totalSold,
      'avg_rating': avgRating
    };
  }
}
