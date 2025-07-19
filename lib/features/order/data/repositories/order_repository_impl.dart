import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/order/data/datasources/order_remote_datasource.dart';
import 'package:thuongmaidientu/features/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/order/domain/repositories/order_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDatasource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<ListModel<OrderItem>> getListOrder(
      String userId, String status) async {
    final userModel = await remoteDataSource.getListOrder(userId, status);
    return userModel;
  }

  @override
  Future<void> createOrder(String userId, String productId, String storeId,
      String variantId, int quantity) async {
    await remoteDataSource.createOrder(
        userId, productId, storeId, variantId, quantity);
  }

  @override
  Future<void> updateOrder(String id, ProductItem productItem) async {
    await remoteDataSource.updateOrder(id, productItem);
  }
}
