import 'package:thuongmaidientu/features/cart/data/models/product_item_model.dart';
import 'package:thuongmaidientu/features/cart/domain/entities/cart_item.dart';
import 'package:thuongmaidientu/features/product/data/models/store_model.dart';

class CartItemModel extends CartItem {
  CartItemModel({
    required StoreModel store,
    required List<ProductItemModel> productItem,
  }) : super(store: store, productItem: productItem);

  factory CartItemModel.fromJson(Map<String, dynamic> map) {
    return CartItemModel(
      store: StoreModel.fromJson(map['store']),
      productItem: (map['productItem'] as List)
          .map((item) => ProductItemModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'store': (store as StoreModel).toJson(),
      'productItem': productItem
          .map((item) => (item as ProductItemModel).toMap())
          .toList(),
    };
  }
}
