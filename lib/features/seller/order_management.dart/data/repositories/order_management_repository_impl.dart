import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/seller/order_management.dart/data/datasources/order_management_remote_datasource.dart';
import 'package:thuongmaidientu/features/seller/order_management.dart/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/seller/order_management.dart/domain/repositories/order_management_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

class OrderManagementRepositoryImpl implements OrderManagementRepository {
  final OrderManagementRemoteDatasource remoteDataSource;

  OrderManagementRepositoryImpl(this.remoteDataSource);

  @override
  Future<ListModel<SellerOrderItem>> getListOrder(
      String storeId, String status) async {
    final userModel = await remoteDataSource.getListOrder(storeId, status);
    return userModel;
  }

  @override
  Future<void> createOrder(String userId, OrderItem order) async {
    await remoteDataSource.createOrder(userId, order);
  }

  @override
  Future<void> updateOrder(String id, ProductItem productItem) async {
    await remoteDataSource.updateOrder(id, productItem);
  }

  @override
  Future<int> getCount(String userId) async {
    final count = await remoteDataSource.getCount(userId);
    return count;
  }
}
