import 'package:thuongmaidientu/features/cart/domain/repositories/cart_repository.dart';

class AddToCartUsecase {
  final CartRepository repository;

  AddToCartUsecase(this.repository);

  Future<void> call(String userId, String productId, String storeId,
      String variantId, int quantity) {
    return repository.addToCart(
        userId, productId, storeId, variantId, quantity);
  }
}
