import 'package:thuongmaidientu/features/cart/data/datasources/product_remote_datasource.dart';
import 'package:thuongmaidientu/features/cart/domain/entities/cart_item.dart';
import 'package:thuongmaidientu/features/cart/domain/repositories/cart_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDatasource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<ListModel<CartItem>> getListCart() async {
    final userModel = await remoteDataSource.getListCart();
    return userModel;
  }
}
