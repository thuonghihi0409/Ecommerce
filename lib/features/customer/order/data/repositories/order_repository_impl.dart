import 'package:thuongmaidientu/features/customer/order/data/datasources/order_remote_datasource.dart';
import 'package:thuongmaidientu/features/customer/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/customer/order/domain/repositories/order_repository.dart';
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
  Future<void> createOrder(String userId, OrderItem order) async {
    await remoteDataSource.createOrder(userId, order);
  }

  @override
  Future<void> updateOrder(String id, OrderItem order) async {
    await remoteDataSource.updateOrder(id, order);
  }

  @override
  Future<int> getCount(String userId) async {
    final count = await remoteDataSource.getCount(userId);
    return count;
  }
}
