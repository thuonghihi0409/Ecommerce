import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/product/data/models/product_detail_model.dart';

class ProductItemModel extends ProductItem {
  ProductItemModel({
    required ProductDetailModel super.productDetail,
    required VariantModel super.variant,
    required super.number,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> map) {
    return ProductItemModel(
      productDetail: ProductDetailModel.fromJson(map['productDetail']),
      variant: VariantModel.fromJson(map['variant']),
      number: map['number'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productDetail': (productDetail as ProductDetailModel).toJson(),
      'variant': (variant as VariantModel).toJson(),
      'number': number,
    };
  }
}
