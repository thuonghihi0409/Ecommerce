part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class GetStatisticDay extends DashboardEvent {
  final String storeId;

  const GetStatisticDay({required this.storeId});
}

class GetStatisticMonth extends DashboardEvent {
  final String storeId;

  const GetStatisticMonth({required this.storeId});
}

class GetStatisticYear extends DashboardEvent {
  final String storeId;

  const GetStatisticYear({required this.storeId});
}
