import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';

class CartItem {
  final Store store;
  final List<ProductItem> productItem;

  CartItem({required this.store, required this.productItem});
}
