import 'dart:developer';

import 'package:thuongmaidientu/features/cart/data/models/cart_item_model.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class CartRemoteDatasource {
  Future<ListModel<CartItemModel>> getListCart(String userId);
}

class CartRemoteDataSourceImpl implements CartRemoteDatasource {
  CartRemoteDataSourceImpl();

  @override
  Future<ListModel<CartItemModel>> getListCart(String userId) async {
    final data = await supabase.from("Carts").select('''
      *,
      store: Stores(*),
      product_carts: ProductCarts(
      id,
      product: Products(*,
        images : Images(*),
        variants : Variants(*)),
      number,
      variant: Variants(*)
      )
      ''').eq('user_id', userId);
    log(data.toString());
    final result = ListModel(
        results: data.map((item) => CartItemModel.fromJson(item)).toList());

    return result;
  }
}
