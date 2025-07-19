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
import 'package:thuongmaidientu/features/cart/data/datasources/cart_remote_datasource.dart';
import 'package:thuongmaidientu/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:thuongmaidientu/features/cart/domain/repositories/cart_repository.dart';
import 'package:thuongmaidientu/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:thuongmaidientu/features/cart/domain/usecases/delete_cart_usecase.dart';
import 'package:thuongmaidientu/features/cart/domain/usecases/update_cart_usecase.dart';
import 'package:thuongmaidientu/features/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:thuongmaidientu/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:thuongmaidientu/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:thuongmaidientu/features/chat/domain/repositories/chat_repository.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/create_conversation_usecase.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/find_conversation_usecase.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/get_list_conversation_usecase.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/get_message_usecase.dart';
import 'package:thuongmaidientu/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:thuongmaidientu/features/chat/presentation/bloc/profile_bloc/chat_bloc.dart';
import 'package:thuongmaidientu/features/order/data/datasources/order_remote_datasource.dart';
import 'package:thuongmaidientu/features/order/data/repositories/order_repository_impl.dart';
import 'package:thuongmaidientu/features/order/domain/repositories/order_repository.dart';
import 'package:thuongmaidientu/features/order/domain/usecases/create_order_usecase.dart';
import 'package:thuongmaidientu/features/order/domain/usecases/get_list_order_usecase.dart';
import 'package:thuongmaidientu/features/order/domain/usecases/update_order_usecase.dart';
import 'package:thuongmaidientu/features/order/presentation/bloc/order_bloc/order_bloc.dart';
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

  sl.registerFactory(() => CartBloc(sl(), sl(), sl(), sl()));

  sl.registerFactory(() => ReviewBloc(sl()));

  sl.registerFactory(() => ProfileBloc(sl(), sl(), sl(), sl(), sl()));

  sl.registerFactory(() => ChatBloc(sl(), sl(), sl(), sl(), sl()));

  sl.registerFactory(() => OrderBloc(sl(), sl(), sl()));

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
  sl.registerLazySingleton(() => AddToCartUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCartUsecase(sl()));
  sl.registerLazySingleton(() => DeleteCartUsecase(sl()));

  //// Review UseCase
  sl.registerLazySingleton(() => GetListReviewUseCase(sl()));

  //// Chat UseCase
  sl.registerLazySingleton(() => GetListConversationUseCase(sl()));
  sl.registerLazySingleton(() => CreateConversationUsecase(sl()));
  sl.registerLazySingleton(() => SendMessageUsecase(sl()));
  sl.registerLazySingleton(() => GetMessageUseCase(sl()));
  sl.registerLazySingleton(() => FindConversationUsecase(sl()));

  //// Order UseCase
  sl.registerLazySingleton(() => GetListOrderUseCase(sl()));
  sl.registerLazySingleton(() => CreateOrderUsecase(sl()));
  sl.registerLazySingleton(() => UpdateOrderUsecase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl()));

  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl()));

  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));

  sl.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(sl()));

  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));

  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl()));

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

  sl.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl());

  sl.registerLazySingleton<OrderRemoteDatasource>(
      () => OrderRemoteDataSourceImpl());
}
