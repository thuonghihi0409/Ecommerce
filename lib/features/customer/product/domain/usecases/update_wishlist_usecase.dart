import 'package:thuongmaidientu/features/customer/product/domain/repositories/product_repository.dart';

class UpdateWishlistUsecase {
  final ProductRepository repository;

  UpdateWishlistUsecase(this.repository);
  Future<void> call(String id, String userId, bool isLike) {
    return repository.updateWishlist(id, userId, isLike);
  }
}
