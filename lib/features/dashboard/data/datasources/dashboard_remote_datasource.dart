import 'package:thuongmaidientu/features/cart/data/models/cart_item_model.dart';
import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class DashboardRemoteDatasource {
  Future<int> getCount(String userId);
  Future<ListModel<CartItemModel>> getListCart(String userId);
  Future<void> addToCart(String userId, String productId, String storeId,
      String variantId, int quantity);
  Future<void> updateCart(String userId, ProductItem productItem);
  Future<void> deleteCart(String cartId, String userId, String productItemId);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDatasource {
  DashboardRemoteDataSourceImpl();

  @override
  Future<ListModel<CartItemModel>> getListCart(String userId) async {
    final data = await supabase.from("Carts").select('''
      *,
      store: Stores(*),
      product_carts: ProductCarts(
      id,
      product: Products(*,
        images : Images(*),
        variants : Variants(*),
        store: Stores(*)),
      number,
      variant: Variants(*)
      )
      ''').eq('user_id', userId);

    final result = ListModel(
        results: data.map((item) => CartItemModel.fromJson(item)).toList());

    return result;
  }

  @override
  Future<void> addToCart(String userId, String productId, String storeId,
      String variantId, int quantity) async {
    //// get id and check cart avaiable
    final data = await supabase.from("Carts").select('''
      id
      ''').eq('user_id', userId).eq("store_id", storeId).maybeSingle();
    String id = "";
    if (data == null) {
      final newdata = await supabase
          .from("Carts")
          .insert({
            'user_id': userId,
            'store_id': storeId,
          })
          .select()
          .single();
      id = newdata["id"];
    } else {
      id = data["id"];
    }

    final result = await supabase.from("ProductCarts").select('''
      *
      ''').eq('cart_id', id).eq("variant_id", variantId).maybeSingle();

    if (result == null) {
      await supabase
          .from("ProductCarts")
          .insert({
            'user_id': userId,
            'cart_id': id,
            'product_id': productId,
            'variant_id': variantId,
            'number': quantity
          })
          .select()
          .single();
    } else {
      int oldQuantity = result['number'] ?? 0;
      int newQuantity = quantity + oldQuantity;
      await supabase
          .from('ProductCarts')
          .update({'number': newQuantity}).eq('id', result['id']);
    }
  }

  @override
  Future<void> updateCart(String userId, productItem) async {
    await supabase.from('ProductCarts').update({
      'number': productItem.number,
      'variant_id': productItem.variant?.id
    }).eq('id', productItem.id);
  }

  @override
  Future<void> deleteCart(
      String cartId, String userId, String productItemId) async {
    await supabase.from('ProductCarts').delete().eq('id', productItemId);
    final result = await supabase
        .from('ProductCarts')
        .select('''*''')
        .eq('cart_id', cartId)
        .maybeSingle();
    if (result == null) {
      await supabase.from("Carts").delete().eq('id', cartId);
    }
  }

  @override
  Future<int> getCount(String userId) async {
    final data =
        await supabase.from('ProductCarts').select('*').eq('user_id', userId);
    return data.length;
  }
}
