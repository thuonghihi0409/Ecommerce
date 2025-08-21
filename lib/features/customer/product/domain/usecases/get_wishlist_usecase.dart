import 'package:thuongmaidientu/features/customer/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/customer/product/domain/repositories/product_repository.dart';

class GetWishlistUsecase {
  final ProductRepository repository;

  GetWishlistUsecase(this.repository);
  Future<List<ProductDetail>> call(String userId) {
    return repository.getWishlist(userId);
  }
}
