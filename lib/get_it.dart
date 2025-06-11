// lib/features/product/product_injection.dart
import 'package:get_it/get_it.dart';
import 'package:thuongmaidientu/features/product/data/datasources/product_remote_datasource.dart';
import 'package:thuongmaidientu/features/product/data/repositories/product_repository_impl.dart';
import 'package:thuongmaidientu/features/product/domain/repositories/product_repository.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_list_product_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_product_detail_usecase.dart';
import 'package:thuongmaidientu/features/product/presentation/bloc/product_bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ProductBloc(sl(), sl()));

  // UseCase
  sl.registerLazySingleton(() => GetListProductUseCase(sl()));
  sl.registerLazySingleton(() => GetProductDetailUsecase(sl()));
  // Repository
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl()));

  // DataSource
  sl.registerLazySingleton<ProductRemoteDatasource>(
      () => ProductRemoteDataSourceImpl());
}
