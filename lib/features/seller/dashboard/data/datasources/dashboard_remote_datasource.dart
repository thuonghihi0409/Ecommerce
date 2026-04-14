import 'package:thuongmaidientu/features/seller/dashboard/data/models/statistic_model.dart';
import 'package:thuongmaidientu/features/seller/dashboard/domain/entities/top_ordered_product_entity.dart';
import 'package:thuongmaidientu/features/seller/dashboard/domain/entities/transaction_entity.dart';
import 'package:thuongmaidientu/features/seller/dashboard/domain/entities/transaction_status_entity.dart';
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

    // Doanh thu seller nên tính theo đơn đã giao, không phụ thuộc is_payment
    // (COD có thể không cập nhật is_payment = true).
    final revenues = await supabase
        .from('Orders')
        .select('total')
        .eq('store_id', storeId)
        .eq('status', 'delivered');
    final totalRevenue = revenues.fold<int>(0, (sum, item) {
      final total = item['total'];
      if (total is int) return sum + total;
      if (total is num) return sum + total.toInt();
      return sum + (int.tryParse(total?.toString() ?? '') ?? 0);
    });
    final transaction = supabase.from("Transactions").select();
    final fail = await transaction.eq("status", "failed");
    final succes = await transaction.eq("status", "success");
    return StatisticModel(
        topAvgRatingProducts: listRatingPrduct,
        totalOrders: totalOrder,
        totalProducts: totalProduct,
        topOrderedProducts: listPrduct,
        transactions:
            TransactionEntity(total: fail.length + succes.length, statuses: [
          TransactionStatusEntity(status: "success", count: succes.length),
          TransactionStatusEntity(status: "failed", count: fail.length),
        ]),
        revenue: null,
        totalRevenue: totalRevenue);
  }
}
