import 'package:thuongmaidientu/features/customer/product/data/models/product_detail_model.dart';
import 'package:thuongmaidientu/features/order/domain/entities/order_product_item.dart';

class OrderProductItemModel extends OrderProductItem {
  OrderProductItemModel(
      {required super.id,
      required super.productDetail,
      required super.variant,
      required super.number,
      required super.isReviewed});

  factory OrderProductItemModel.fromJson(Map<String, dynamic> map) {
    return OrderProductItemModel(
        id: map['id'],
        productDetail: ProductDetailModel.fromJson(map['product']),
        variant: VariantModel.fromJson(map['variant']),
        number: map['number'] ?? 1,
        isReviewed: map["is_reviewed"]);
  }

  Map<String, dynamic> toMap() {
    return {
      'product_detail': (productDetail as ProductDetailModel).toJson(),
      'variant': (variant as VariantModel).toJson(),
      'number': number,
      'id': id
    };
  }
}
