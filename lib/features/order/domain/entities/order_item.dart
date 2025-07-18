import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';

class OrderItem {
  final String id;
  final Store store;
  final List<ProductItem> productItem;

  OrderItem({required this.store, required this.productItem, required this.id});
}
