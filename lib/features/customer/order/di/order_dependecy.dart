import 'package:thuongmaidientu/features/customer/order/data/datasources/order_remote_datasource.dart';
import 'package:thuongmaidientu/features/customer/order/data/repositories/order_repository_impl.dart';
import 'package:thuongmaidientu/features/customer/order/domain/repositories/order_repository.dart';
import 'package:thuongmaidientu/features/customer/order/domain/usecases/create_order_usecase.dart';
import 'package:thuongmaidientu/features/customer/order/domain/usecases/get_count_order.dart';
import 'package:thuongmaidientu/features/customer/order/domain/usecases/get_list_order_usecase.dart';
import 'package:thuongmaidientu/features/customer/order/domain/usecases/update_order_usecase.dart';
import 'package:thuongmaidientu/features/customer/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:thuongmaidientu/get_it.dart';

class OrderDependecy {
  static void init() {
    sl.registerFactory(() => OrderBloc(sl(), sl(), sl(), sl(), sl()));

    //// Order UseCase
    sl.registerLazySingleton(() => GetListOrderUseCase(sl()));
    sl.registerLazySingleton(() => CreateOrderUsecase(sl()));
    sl.registerLazySingleton(() => UpdateOrderUsecase(sl()));
    sl.registerLazySingleton(() => GetCountOrderUseCase(sl()));

    sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl()));

    sl.registerLazySingleton<OrderRemoteDatasource>(
        () => OrderRemoteDataSourceImpl());
  }
}
