import 'package:thuongmaidientu/features/cart/domain/repositories/cart_repository.dart';

class DeleteCartUsecase {
  final CartRepository repository;

  DeleteCartUsecase(this.repository);

  Future<void> call(String cartId, String userId, String productItemId) {
    return repository.deleteCart(cartId, userId, productItemId);
  }
}
