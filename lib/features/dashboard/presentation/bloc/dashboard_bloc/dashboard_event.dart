part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class GetOverView extends DashboardEvent {}

class GetStatisticDay extends DashboardEvent {}

class GetStatisticMonth extends DashboardEvent {}

class GetStatisticYear extends DashboardEvent {}
