import 'package:thuongmaidientu/features/customer/order/domain/entities/order_item.dart';
import 'package:thuongmaidientu/features/seller/order_management.dart/data/models/order_item_model.dart';
import 'package:thuongmaidientu/features/seller/order_management.dart/domain/entities/seller_order_item.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class OrderManagementRemoteDatasource {
  Future<ListModel<SellerOrderItemModel>> getListOrder(
      String storeId, String status);
  Future<int> getCount(String userId);

  Future<void> updateOrder(String userId, SellerOrderItem order);
}

class OrderManagementRemoteDataSourceImpl
    implements OrderManagementRemoteDatasource {
  OrderManagementRemoteDataSourceImpl();

  @override
  Future<ListModel<SellerOrderItemModel>> getListOrder(
      String storeId, String status) async {
    final data = await supabase
        .from("Orders")
        .select('''
      *,
      user: Users(*),
      product_orders: ProductOrders(
      id,
      product: Products(*,
        images : Images(*),
        variants : Variants(
        *,
        prices:Prices!inner(*)
      ),
        store: Stores(*)),
      number,
      variant: Variants(
        *,
        prices:Prices!inner(*)
      )
      
      ),address: Address(*)
      ''')
        .eq('store_id', storeId)
        .eq('status', status)
        .order('created_at',
            ascending: false,
            referencedTable:
                'product_orders.product.variants.prices') // sắp xếp bảng con
        .limit(1, referencedTable: 'product_orders.product.variants.prices');

    final result = ListModel(
        results:
            data.map((item) => SellerOrderItemModel.fromJson(item)).toList());

    return result;
  }

  @override
  Future<void> updateOrder(String userId, SellerOrderItem order) async {
    if (order.status == OrderStatus.delivering) {
      final Map<String, int> soldByProduct = {};
      await Future.wait(order.productItem.map((item) async {
        final productId = item.productDetail?.productId;
        if (productId != null && productId.isNotEmpty) {
          soldByProduct[productId] =
              (soldByProduct[productId] ?? 0) + item.number;
        }
        await supabase.from('Variants').update({
          'stock': (item.variant?.stock ?? 0) - item.number,
          'total_sold': (item.variant?.totalSold ?? 0) + item.number
        }).eq('id', item.variant?.id ?? "");
      }));

      // Đồng bộ số đã bán của bảng Products để UI customer/seller hiển thị đúng.
      await Future.wait(soldByProduct.entries.map((entry) async {
        final product = await supabase
            .from('Products')
            .select('total_sold')
            .eq('id', entry.key)
            .maybeSingle();
        final currentSold = (product?['total_sold'] as num?)?.toInt() ?? 0;
        await supabase.from('Products').update({
          'total_sold': currentSold + entry.value,
        }).eq('id', entry.key);
      }));
    }
    await supabase.from('Orders').update(
        {'status': orderStatusToString(order.status)}).eq('id', order.id);
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
