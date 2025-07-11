import 'package:get_it/get_it.dart';
import 'package:thuongmaidientu/features/Cart/domain/usecases/get_list_Cart_usecase.dart';
import 'package:thuongmaidientu/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:thuongmaidientu/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:thuongmaidientu/features/auth/domain/repositories/auth_repository.dart';
import 'package:thuongmaidientu/features/auth/domain/usecases/login_usecase.dart';
import 'package:thuongmaidientu/features/auth/domain/usecases/logout_usecase.dart';
import 'package:thuongmaidientu/features/auth/domain/usecases/register_usecase.dart';
import 'package:thuongmaidientu/features/auth/domain/usecases/verify_email_usecase.dart';
import 'package:thuongmaidientu/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
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
import 'package:thuongmaidientu/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:thuongmaidientu/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:thuongmaidientu/features/profile/domain/repositories/profile_repository.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/add_address_usecase.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/get_address_usecase.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/get_provinces_usecase.dart';
import 'package:thuongmaidientu/features/profile/domain/usecases/get_wards_usecase.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/features/review/data/datasources/review_remote_datasource.dart';
import 'package:thuongmaidientu/features/review/data/repositories/review_repository_impl.dart';
import 'package:thuongmaidientu/features/review/domain/repositories/review_repository.dart';
import 'package:thuongmaidientu/features/review/domain/usecases/get_list_review_usecase.dart';
import 'package:thuongmaidientu/features/review/presentation/bloc/review_bloc/review_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl(), sl()));

  sl.registerFactory(() => ProductBloc(sl(), sl(), sl(), sl(), sl()));

  sl.registerFactory(() => CartBloc(sl()));

  sl.registerFactory(() => ReviewBloc(sl()));

  sl.registerFactory(() => ProfileBloc(sl(), sl(), sl(), sl(), sl()));

  // UseCase
  //// Auth UseCase
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUsecase(sl()));
  sl.registerLazySingleton(() => SendVerifyEmailUsecase(sl()));

  //// Profile UseCase
  sl.registerLazySingleton(() => GetProfileUsecase(sl()));
  sl.registerLazySingleton(() => GetProvincesUsecase(sl()));
  sl.registerLazySingleton(() => GetAddressUsecase(sl()));
  sl.registerLazySingleton(() => GetWardsUsecase(sl()));
  sl.registerLazySingleton(() => AddAddressUsecase(sl()));

  //// Product UseCase
  sl.registerLazySingleton(() => GetListProductUseCase(sl()));
  sl.registerLazySingleton(() => GetProductDetailUsecase(sl()));
  sl.registerLazySingleton(() => GetListProductSummericeUseCase(sl()));
  sl.registerLazySingleton(() => GetStoreUsecase(sl()));
  sl.registerLazySingleton(() => GetListCategoryUseCase(sl()));

  //// Cart UseCase
  sl.registerLazySingleton(() => GetListCartUseCase(sl()));

  //// Review UseCase
  sl.registerLazySingleton(() => GetListReviewUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl()));

  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl()));

  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));

  sl.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(sl()));

  // DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());
  sl.registerLazySingleton<ProfileRemoteDatasource>(
      () => ProfileRemoteDataSourceImpl());
  sl.registerLazySingleton<ProductRemoteDatasource>(
      () => ProductRemoteDataSourceImpl());

  sl.registerLazySingleton<CartRemoteDatasource>(
      () => CartRemoteDataSourceImpl());

  sl.registerLazySingleton<ReviewRemoteDatasource>(
      () => ReviewRemoteDataSourceImpl());
}
