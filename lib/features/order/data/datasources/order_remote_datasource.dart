import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/order/data/models/order_item_model.dart';
import 'package:thuongmaidientu/features/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class OrderRemoteDatasource {
  Future<ListModel<OrderItemModel>> getListOrder(String userId, String status);
  Future<int> getCount(String userId);
  Future<void> createOrder(String userId, OrderItem order);
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

    final result = ListModel(
        results: data.map((item) => OrderItemModel.fromJson(item)).toList());

    return result;
  }

  @override
  Future<void> createOrder(String userId, OrderItem order) async {
    final newdata = await supabase
        .from("Orders")
        .insert({
          'user_id': userId,
          'store_id': order.store.id,
          'address_id': order.address?.id,
          'total': order.total,
          'subtotal': order.subtotal,
          'status': orderStatusToString(order.status)
        })
        .select()
        .single();
    final id = newdata["id"];

    await supabase.from("ProductOrders").insert(order.productItem
        .map((item) => {
              'order_id': id,
              'product_id': item.productDetail?.productId,
              'variant_id': item.variant?.id,
              'number': item.number
            })
        .toList());
  }

  @override
  Future<void> updateOrder(String userId, productItem) async {
    await supabase.from('ProductCarts').update({
      'number': productItem.number,
      'variant_id': productItem.variant?.id
    }).eq('id', productItem.id);
  }

  @override
  Future<int> getCount(String userId) async {
    final data = await supabase
        .from('Orders')
        .select('status')
        .eq('user_id', userId)
        .filter('status', 'in', '("pending","awaiting","delivering")');
    return data.length;
  }
}
