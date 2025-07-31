import 'package:thuongmaidientu/features/customer/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class OrderRepository {
  Future<ListModel<OrderItem>> getListOrder(String userId, String status);
  Future<void> createOrder(String userId, OrderItem order);
  Future<void> updateOrder(String id, OrderItem order);
  Future<int> getCount(String userId);
}
