import 'package:thuongmaidientu/features/customer/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/customer/order/domain/repositories/order_repository.dart';

class CreateOrderUsecase {
  final OrderRepository repository;

  CreateOrderUsecase(this.repository);

  Future<void> call(String userId, OrderItem order) {
    return repository.createOrder(userId, order);
  }
}
