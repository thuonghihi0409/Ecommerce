import 'package:thuongmaidientu/features/customer/product/domain/entities/product_detail.dart';

class OrderProductItem {
  final String id;
  final ProductDetail? productDetail;
  final Variant? variant;
  final Price? price;
  final int number;
  final bool isReviewed;

  OrderProductItem(
      {required this.id,
      required this.productDetail,
      required this.variant,
      required this.price,
      required this.number,
      required this.isReviewed});
  OrderProductItem copyWith(
      {String? id,
      ProductDetail? productDetail,
      Variant? variant,
      Price? price,
      int? number,
      bool? isReviewed}) {
    return OrderProductItem(
        id: id ?? this.id,
        price: price ?? this.price,
        productDetail: productDetail ?? this.productDetail,
        variant: variant ?? this.variant,
        number: number ?? this.number,
        isReviewed: isReviewed ?? this.isReviewed);
  }
}
