import 'package:thuongmaidientu/features/cart/domain/repositories/cart_repository.dart';

class GetCountCartUsecase {
  final CartRepository repository;

  GetCountCartUsecase(this.repository);

  Future<int> call(String userId) {
    return repository.getCount(userId);
  }
}
