import 'dart:developer';

import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/order/data/models/order_item_model.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class OrderRemoteDatasource {
  Future<ListModel<OrderItemModel>> getListOrder(String userId, String status);
  Future<void> createOrder(String userId, String productId, String storeId,
      String variantId, int quantity);
  Future<void> updateOrder(String userId, ProductItem productItem);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDatasource {
  OrderRemoteDataSourceImpl();

  @override
  Future<ListModel<OrderItemModel>> getListOrder(
      String userId, String status) async {
    final data = await supabase.from("Orders").select('''
      *,
      store: Stores(*),
      product_orders: ProductOrders(
      id,
      product: Products(*,
        images : Images(*),
        variants : Variants(*),
        store: Stores(*)),
      number,
      variant: Variants(*)
      
      ),address: Address(*)
      ''').eq('user_id', userId).eq('status', status);
    log(data.toString());
    final result = ListModel(
        results: data.map((item) => OrderItemModel.fromJson(item)).toList());

    return result;
  }

  @override
  Future<void> createOrder(String userId, String productId, String storeId,
      String variantId, int quantity) async {
    final newdata = await supabase
        .from("Carts")
        .insert({
          'user_id': userId,
          'store_id': storeId,
        })
        .select()
        .single();
    final id = newdata["id"];

    final result = await supabase.from("ProductCarts").select('''
      *
      ''').eq('cart_id', id).eq("variant_id", variantId).maybeSingle();

    if (result == null) {
      await supabase
          .from("ProductCarts")
          .insert({
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
  Future<void> updateOrder(String userId, productItem) async {
    await supabase.from('ProductCarts').update({
      'number': productItem.number,
      'variant_id': productItem.variant?.id
    }).eq('id', productItem.id);
  }
}
