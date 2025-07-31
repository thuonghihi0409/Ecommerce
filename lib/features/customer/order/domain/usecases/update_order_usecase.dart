import 'package:thuongmaidientu/features/customer/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/customer/order/domain/repositories/order_repository.dart';

class UpdateOrderUsecase {
  final OrderRepository repository;

  UpdateOrderUsecase(this.repository);

  Future<void> call(String userId, OrderItem order) {
    return repository.updateOrder(userId, order);
  }
}
