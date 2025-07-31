import 'package:thuongmaidientu/features/customer/cart/domain/repositories/cart_repository.dart';

class GetCountCartUsecase {
  final CartRepository repository;

  GetCountCartUsecase(this.repository);

  Future<int> call(String userId) {
    return repository.getCount(userId);
  }
}
