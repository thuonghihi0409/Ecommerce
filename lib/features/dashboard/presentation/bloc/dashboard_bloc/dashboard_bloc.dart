import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/features/dashboard/domain/entities/statistic_entity.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState.empty()) {
    on<GetStatisticDay>(_getStatisticDay);
    on<GetStatisticMonth>(_getStatisticMonth);
    on<GetStatisticYear>(_getStatisticYear);
  }

  void _getStatisticDay(
      GetStatisticDay event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(isLoadingDay: true));

      Map<String, dynamic> param = {"filterType": "day"};
      StatisticEntity? newStatistic;

      emit(state.copyWith(
          statisticDay: newStatistic ?? state.statisticDay,
          isLoadingDay: false,
          errorMessageDay: ""));
    } catch (e) {
      emit(state.copyWith(
          isLoadingDay: false,
          errorMessageDay: ParseError.fromJson(e).message));
    }
  }

  void _getStatisticMonth(
      GetStatisticMonth event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(isLoadingMonth: true));

      Map<String, dynamic> param = {"filterType": "month"};
      StatisticEntity? newStatistic;

      emit(state.copyWith(
          statisticMonth: newStatistic ?? state.statisticMonth,
          isLoadingMonth: false,
          errorMessageMonth: ""));
    } catch (e) {
      emit(state.copyWith(
          isLoadingMonth: false,
          errorMessageMonth: ParseError.fromJson(e).message));
    }
  }

  void _getStatisticYear(
      GetStatisticYear event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(isLoadingYear: true));

      Map<String, dynamic> param = {"filterType": "all"};
      StatisticEntity? newStatistic;

      emit(state.copyWith(
          statisticYear: newStatistic ?? state.statisticYear,
          isLoadingYear: false,
          errorMessageYear: ""));
    } catch (e) {
      emit(state.copyWith(
          isLoadingYear: false,
          errorMessageYear: ParseError.fromJson(e).message));
    }
  }
}
