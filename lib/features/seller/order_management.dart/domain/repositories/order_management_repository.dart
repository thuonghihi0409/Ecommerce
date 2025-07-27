import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/seller/order_management.dart/domain/entities/order_item.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class OrderManagementRepository {
  Future<ListModel<SellerOrderItem>> getListOrder(
      String storeId, String status);
  Future<void> createOrder(String userId, OrderItem order);
  Future<void> updateOrder(String id, ProductItem productItem);
  Future<int> getCount(String userId);
}
