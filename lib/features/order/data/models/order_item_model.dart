import 'package:thuongmaidientu/features/cart/data/models/product_item_model.dart';
import 'package:thuongmaidientu/features/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/product/data/models/store_model.dart';
import 'package:thuongmaidientu/features/profile/domain/entities/address_entity.dart';

class OrderItemModel extends OrderItem {
  OrderItemModel(
      {required super.store,
      required super.productItem,
      required super.id,
      required super.address,
      required super.status,
      required super.subtotal,
      required super.total});

  factory OrderItemModel.fromJson(Map<String, dynamic> map) {
    return OrderItemModel(
      total: map['total'],
      subtotal: map['subtotal'],
      status: orderStatusFromString(map['status']),
      address: AddressEntity.fromJson(map['address']),
      id: map['id'],
      store: StoreModel.fromJson(map['store']),
      productItem: (map['product_orders'] as List)
          .map((item) => ProductItemModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'subtotal': subtotal,
      'store': (store as StoreModel).toJson(),
      'status': orderStatusToString(status),
      'address': address?.toJson(),
      'product_item': productItem
          .map((item) => (item as ProductItemModel).toMap())
          .toList(),
    };
  }
}
