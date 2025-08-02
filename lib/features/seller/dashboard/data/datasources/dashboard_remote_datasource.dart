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
        .map((item) => TopProductEntity(
            id: item["id"],
            totalOrdered: item["total_sold"],
            avgRating: item["avg_rating"],
            name: item["product_name"]))
        .toList();

    final topRatingProducts = await supabase
        .from('Products')
        .select('*')
        .eq('store_id', storeId)
        .order('avg_rating', ascending: false)
        .limit(10);
    final listRatingPrduct = topRatingProducts
        .map((item) => TopProductEntity(
            id: item["id"],
            totalOrdered: item["total_sold"],
            avgRating: item["avg_rating"],
            name: item["product_name"]))
        .toList();

    final totalOrdersRes =
        await supabase.from('Orders').select('id').eq('store_id', storeId);
    final totalOrder = totalOrdersRes.length;
    return StatisticModel(
        topAvgRatingProducts: listRatingPrduct,
        totalOrders: totalOrder,
        totalProducts: totalProduct,
        topOrderedProducts: listPrduct,
        transactions: null,
        revenue: null,
        totalRevenue: null);
  }
}
