import 'package:thuongmaidientu/features/seller/dashboard/data/models/statistic_model.dart';
import 'package:thuongmaidientu/features/seller/dashboard/domain/entities/top_ordered_product_entity.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';

abstract class DashboardRemoteDatasource {
  Future<StatisticModel> getDashboard(String storeId);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDatasource {
  DashboardRemoteDataSourceImpl();

  @override
  Future<StatisticModel> getDashboard(String storeId) async {
    final totalProductsRes =
        await supabase.from('Products').select('id').eq('store_id', storeId);
    final totalProduct = totalProductsRes.length;
    final topProducts = await supabase
        .from('Products')
        .select('*')
        .eq('store_id', storeId)
        .order('total_sold', ascending: false)
        .limit(10);
    final listPrduct = topProducts
        .map((item) => TopOrderedProductEntity(
            id: item["id"],
            totalOrdered: item["total_sold"],
            name: item["product_name"]))
        .toList();

    final totalOrdersRes =
        await supabase.from('Orders').select('id').eq('store_id', storeId);
    final totalOrder = totalOrdersRes.length;
    return StatisticModel(
        totalOrders: totalOrder,
        totalProducts: totalProduct,
        topOrderedProducts: listPrduct,
        transactions: null,
        revenue: null,
        totalRevenue: null);
  }
}
