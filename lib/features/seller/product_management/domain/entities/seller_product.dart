import 'package:thuongmaidientu/features/customer/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/product_detail.dart';

class SellerProduct {
  final String productId;
  final String? productName;
  final String? description;
  final int? price;

  final Category category;
  final String? status;
  final List<Variant>? variants;
  final double? avgRating;
  final int? totalSold;
  final int? totalRating;
  final String? cover;

  SellerProduct(
      {required this.productId,
      required this.productName,
      required this.description,
      required this.price,
      required this.category,
      required this.status,
      required this.variants,
      required this.avgRating,
      required this.totalRating,
      required this.totalSold,
      required this.cover});
}
