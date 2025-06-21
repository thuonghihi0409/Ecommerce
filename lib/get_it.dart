// lib/features/product/product_injection.dart
import 'package:get_it/get_it.dart';
import 'package:thuongmaidientu/features/Cart/domain/usecases/get_list_Cart_usecase.dart';
import 'package:thuongmaidientu/features/cart/data/datasources/product_remote_datasource.dart';
import 'package:thuongmaidientu/features/cart/data/repositories/product_repository_impl.dart';
import 'package:thuongmaidientu/features/cart/domain/repositories/cart_repository.dart';
import 'package:thuongmaidientu/features/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:thuongmaidientu/features/product/data/datasources/product_remote_datasource.dart';
import 'package:thuongmaidientu/features/product/data/repositories/product_repository_impl.dart';
import 'package:thuongmaidientu/features/product/domain/repositories/product_repository.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_list_category_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_list_product_summerice_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_list_product_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_product_detail_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_store_usecase.dart';
import 'package:thuongmaidientu/features/product/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:thuongmaidientu/features/review/data/datasources/review_remote_datasource.dart';
import 'package:thuongmaidientu/features/review/data/repositories/review_repository_impl.dart';
import 'package:thuongmaidientu/features/review/domain/repositories/review_repository.dart';
import 'package:thuongmaidientu/features/review/domain/usecases/get_list_review_usecase.dart';
import 'package:thuongmaidientu/features/review/presentation/bloc/review_bloc/review_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ProductBloc(sl(), sl(), sl(), sl(), sl()));

  sl.registerFactory(() => CartBloc(sl()));

  sl.registerFactory(() => ReviewBloc(sl()));

  // UseCase
  sl.registerLazySingleton(() => GetListProductUseCase(sl()));
  sl.registerLazySingleton(() => GetProductDetailUsecase(sl()));
  sl.registerLazySingleton(() => GetListProductSummericeUseCase(sl()));
  sl.registerLazySingleton(() => GetStoreUsecase(sl()));
  sl.registerLazySingleton(() => GetListCategoryUseCase(sl()));

  sl.registerLazySingleton(() => GetListCartUseCase(sl()));

  sl.registerLazySingleton(() => GetListReviewUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl()));

  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));

  sl.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(sl()));

  // DataSource
  sl.registerLazySingleton<ProductRemoteDatasource>(
      () => ProductRemoteDataSourceImpl());

  sl.registerLazySingleton<CartRemoteDatasource>(
      () => CartRemoteDataSourceImpl());

  sl.registerLazySingleton<ReviewRemoteDatasource>(
      () => ReviewRemoteDataSourceImpl());
}
