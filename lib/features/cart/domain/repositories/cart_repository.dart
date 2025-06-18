import 'package:thuongmaidientu/features/cart/domain/entities/cart_item.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class CartRepository {
  Future<ListModel<CartItem>> getListCart();
}
