import 'dart:developer';

import 'package:thuongmaidientu/features/customer/cart/data/datasources/cart_remote_datasource.dart';
import 'package:thuongmaidientu/features/customer/cart/data/repositories/cart_repository_impl.dart';
import 'package:thuongmaidientu/features/customer/cart/domain/repositories/cart_repository.dart';
import 'package:thuongmaidientu/features/customer/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:thuongmaidientu/features/customer/cart/domain/usecases/delete_cart_usecase.dart';
import 'package:thuongmaidientu/features/customer/cart/domain/usecases/get_count_cart_usecase.dart';
import 'package:thuongmaidientu/features/customer/cart/domain/usecases/get_list_cart_usecase.dart';
import 'package:thuongmaidientu/features/customer/cart/domain/usecases/update_cart_usecase.dart';
import 'package:thuongmaidientu/features/customer/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:thuongmaidientu/get_it.dart';

class CartDependecy {
  static void init() {
    log("Registering CartRemoteDataSource");
    sl.registerLazySingleton<CartRemoteDatasource>(
        () => CartRemoteDataSourceImpl());

    log("Registering CartRepository");
    sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));

    log("Registering UseCases");
    sl.registerLazySingleton(() => GetListCartUseCase(sl()));
    sl.registerLazySingleton(() => AddToCartUsecase(sl()));
    sl.registerLazySingleton(() => UpdateCartUsecase(sl()));
    sl.registerLazySingleton(() => DeleteCartUsecase(sl()));
    sl.registerLazySingleton(() => GetCountCartUsecase(sl()));

    log("Registering CartBloc");
    sl.registerFactory(() => CartBloc(sl(), sl(), sl(), sl(), sl()));
    log("CartBloc registered ✅");
  }
}
