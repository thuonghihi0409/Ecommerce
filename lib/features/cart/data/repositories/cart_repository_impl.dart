import 'package:thuongmaidientu/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:thuongmaidientu/features/cart/domain/entities/cart_item.dart';
import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/cart/domain/repositories/cart_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDatasource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<ListModel<CartItem>> getListCart(String userId) async {
    final userModel = await remoteDataSource.getListCart(userId);
    return userModel;
  }

  @override
  Future<void> addToCart(String userId, String productId, String storeId,
      String variantId, int quantity) async {
    await remoteDataSource.addToCart(
        userId, productId, storeId, variantId, quantity);
  }

  @override
  Future<void> deleteCart(
      String cartId, String userId, String productItemId) async {
    await remoteDataSource.deleteCart(cartId, userId, productItemId);
  }

  @override
  Future<void> updateCart(String id, ProductItem productItem) async {
    await remoteDataSource.updateCart(id, productItem);
  }
}
