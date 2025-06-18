import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';

class ProductItem {
  final ProductDetail productDetail;
  final Variant variant;
  final int number;

  ProductItem(
      {required this.productDetail,
      required this.variant,
      required this.number});
}
