import 'package:thuongmaidientu/features/customer/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/store.dart';

class CartItem {
  final String id;
  final Store store;
  final List<ProductItem> productItem;

  CartItem({required this.store, required this.productItem, required this.id});

  CartItem copyWith(
      {String? id, Store? store, List<ProductItem>? productItem}) {
    return CartItem(
        id: id ?? this.id,
        store: store ?? this.store,
        productItem: productItem ?? this.productItem);
  }
}
