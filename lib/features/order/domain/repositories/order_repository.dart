import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class OrderRepository {
  Future<ListModel<OrderItem>> getListOrder(String userId, String status);
  Future<void> createOrder(String userId, String productId, String storeId,
      String variantId, int quantity);
  Future<void> updateOrder(String id, ProductItem productItem);
}
