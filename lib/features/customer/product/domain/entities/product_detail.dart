import 'package:thuongmaidientu/features/customer/product/domain/entities/promotion.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/store.dart';

class ProductDetail {
  final String productId;
  final String? productName;
  final String? description;
  final int? price;
  final Store? store;
  final String? categoryId;
  final Promotion? promotion;
  final List<ImageItem>? images;
  final List<Variant>? variants;
  final double? avgRating;
  final int? totalSold;
  final int? totalRating;
  final String? cover;
  final bool isLike;

  ProductDetail(
      {required this.productId,
      this.promotion,
      required this.productName,
      required this.description,
      required this.price,
      required this.store,
      required this.categoryId,
      required this.images,
      required this.variants,
      required this.avgRating,
      required this.totalRating,
      required this.totalSold,
      required this.cover,
      required this.isLike});

  ProductDetail copyWith({
    Promotion? promotion,
    String? productId,
    String? productName,
    String? description,
    int? price,
    Store? store,
    String? categoryId,
    List<ImageItem>? images,
    List<Variant>? variants,
    double? avgRating,
    int? totalSold,
    int? totalRating,
    String? cover,
    bool? isLike,
  }) {
    return ProductDetail(
      promotion: promotion ?? this.promotion,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      price: price ?? this.price,
      store: store ?? this.store,
      categoryId: categoryId ?? this.categoryId,
      images: images ?? this.images,
      variants: variants ?? this.variants,
      avgRating: avgRating ?? this.avgRating,
      totalSold: totalSold ?? this.totalSold,
      totalRating: totalRating ?? this.totalRating,
      cover: cover ?? this.cover,
      isLike: isLike ?? this.isLike,
    );
  }
}

class ImageItem {
  final String id;
  final String? url;
  final String? alt;

  ImageItem({
    required this.id,
    required this.url,
    required this.alt,
  });
}

class Variant {
  final String id;
  final String? cover;
  final String? name;
  final int? price;
  final int? stock;
  final int? totalSold;

  Variant(
      {required this.id,
      required this.name,
      required this.price,
      required this.stock,
      required this.cover,
      required this.totalSold});
}
