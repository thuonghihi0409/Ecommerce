import 'package:thuongmaidientu/features/seller/dashboard/domain/entities/statistic_entity.dart';

abstract class SellerDashboardRepository {
  Future<StatisticEntity> getDashboard(String stored);
}
