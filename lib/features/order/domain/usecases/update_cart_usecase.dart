import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/cart/domain/repositories/cart_repository.dart';

class UpdateCartUsecase {
  final CartRepository repository;

  UpdateCartUsecase(this.repository);

  Future<void> call(String userId, ProductItem productItem) {
    return repository.updateCart(userId, productItem);
  }
}
