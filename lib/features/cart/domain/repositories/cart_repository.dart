import 'package:thuongmaidientu/features/cart/domain/entities/cart_item.dart';
import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class CartRepository {
  Future<ListModel<CartItem>> getListCart(String userId);
  Future<void> addToCart(String userId, String productId, String storeId,
      String variantId, int quantity);
  Future<void> updateCart(String id, ProductItem productItem);
  Future<void> deleteCart(String cartId, String userId, String productItemId);
}
