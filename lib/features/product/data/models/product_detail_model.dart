import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';

class ProductDetailModel extends ProductDetail {
  ProductDetailModel(
      {required super.productId,
      required super.productName,
      required super.description,
      required super.price,
      required super.storeId,
      required super.categoryId,
      required super.createdAt,
      required super.updatedAt,
      required super.images,
      required super.variants,
      required super.avgRating,
      required super.totalRating,
      required super.totalSold});

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      totalRating: json['total_rating'],
      avgRating: json['avg_rating'],
      totalSold: json['total_sold'],
      productId: json['product_id'],
      productName: json['product_name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      storeId: json['store_id'],
      categoryId: json['category_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      images:
          (json['images'] as List).map((e) => ImageModel.fromJson(e)).toList(),
      variants: (json['variants'] as List)
          .map((e) => VariantModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'description': description,
      'price': price,
      'store_id': storeId,
      'category_id': categoryId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'total_rating': totalRating,
      'total_sold': totalSold,
      'avg_rating': avgRating
    };
  }
}

class ImageModel extends ImageItem {
  ImageModel({
    required super.id,
    required super.url,
    required super.alt,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      url: json['url'],
      alt: json['alt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'alt': alt,
    };
  }
}

class VariantModel extends Variant {
  VariantModel(
      {required super.id,
      required super.name,
      required super.price,
      required super.stock,
      required super.cover});

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
        id: json['id'],
        name: json['name'],
        price: (json['price'] as num).toDouble(),
        stock: json['stock'],
        cover: json['cover'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
    };
  }
}
