import 'package:thuongmaidientu/features/seller/dashboard/domain/entities/statistic_entity.dart';
import 'package:thuongmaidientu/features/seller/dashboard/domain/repositories/seller_dashboard_repository.dart';

class SellerGetDashboardCartUsecase {
  final SellerDashboardRepository repository;

  SellerGetDashboardCartUsecase(this.repository);

  Future<StatisticEntity> call(String storeId) {
    return repository.getDashboard(storeId);
  }
}
