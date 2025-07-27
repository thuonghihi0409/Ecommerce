import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/order/domain/repositories/order_repository.dart';

class UpdateOrderUsecase {
  final OrderRepository repository;

  UpdateOrderUsecase(this.repository);

  Future<void> call(String userId, ProductItem productItem) {
    return repository.updateOrder(userId, productItem);
  }
}
