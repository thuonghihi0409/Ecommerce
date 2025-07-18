import 'package:thuongmaidientu/features/cart/data/models/product_item_model.dart';
import 'package:thuongmaidientu/features/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/product/data/models/store_model.dart';

class OrderItemModel extends OrderItem {
  OrderItemModel(
      {required super.store, required super.productItem, required super.id});

  factory OrderItemModel.fromJson(Map<String, dynamic> map) {
    return OrderItemModel(
      id: map['id'],
      store: StoreModel.fromJson(map['store']),
      productItem: (map['product_carts'] as List)
          .map((item) => ProductItemModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store': (store as StoreModel).toJson(),
      'product_item': productItem
          .map((item) => (item as ProductItemModel).toMap())
          .toList(),
    };
  }
}
