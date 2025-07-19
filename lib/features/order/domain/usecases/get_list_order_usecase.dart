import 'package:thuongmaidientu/features/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/order/domain/repositories/order_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

class GetListOrderUseCase {
  final OrderRepository repository;

  GetListOrderUseCase(this.repository);

  Future<ListModel<OrderItem>?> call(String userId, String status) async {
    return repository.getListOrder(userId, status);
  }
}
