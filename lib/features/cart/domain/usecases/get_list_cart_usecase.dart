import 'package:thuongmaidientu/features/cart/domain/entities/cart_item.dart';
import 'package:thuongmaidientu/features/cart/domain/repositories/cart_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

class GetListCartUseCase {
  final CartRepository repository;

  GetListCartUseCase(this.repository);

  Future<ListModel<CartItem>?> call() {
    return repository.getListCart();
  }
}
