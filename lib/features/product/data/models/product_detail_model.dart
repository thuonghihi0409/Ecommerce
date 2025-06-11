import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';

class ProductDetailModel extends ProductDetail {
  ProductDetailModel({
    required super.productId,
    required super.productName,
    required super.description,
    required super.price,
    required super.storeId,
    required super.categoryId,
    required super.createdAt,
    required super.updatedAt,
    required super.images,
    required super.variants,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      productId: json['productId'],
      productName: json['productName'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      storeId: json['storeId'],
      categoryId: json['categoryId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      images:
          (json['images'] as List).map((e) => ImageModel.fromJson(e)).toList(),
      variants: (json['variants'] as List)
          .map((e) => VariantModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'description': description,
      'price': price,
      'storeId': storeId,
      'categoryId': categoryId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
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
  VariantModel({
    required super.id,
    required super.name,
    required super.price,
    required super.stock,
  });

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      stock: json['stock'],
    );
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
