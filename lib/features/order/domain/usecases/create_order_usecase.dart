import 'package:thuongmaidientu/features/order/domain/repositories/order_repository.dart';

class CreateOrderUsecase {
  final OrderRepository repository;

  CreateOrderUsecase(this.repository);

  Future<void> call(String userId, String productId, String storeId,
      String variantId, int quantity) {
    return repository.createOrder(
        userId, productId, storeId, variantId, quantity);
  }
}
