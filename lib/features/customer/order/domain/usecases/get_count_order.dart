import 'package:thuongmaidientu/features/customer/order/domain/repositories/order_repository.dart';

class GetCountOrderUseCase {
  final OrderRepository repository;

  GetCountOrderUseCase(this.repository);

  Future<int> call(String userId) async {
    return repository.getCount(userId);
  }
}
