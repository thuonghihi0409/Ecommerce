import 'package:thuongmaidientu/features/seller/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:thuongmaidientu/features/seller/dashboard/domain/entities/statistic_entity.dart';
import 'package:thuongmaidientu/features/seller/dashboard/domain/repositories/seller_dashboard_repository.dart';

class SellerDashboardRepositoryImpl implements SellerDashboardRepository {
  final DashboardRemoteDatasource remoteDataSource;

  SellerDashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<StatisticEntity> getDashboard(String storeId) async {
    final count = await remoteDataSource.getDashboard(storeId);
    return count;
  }
}
