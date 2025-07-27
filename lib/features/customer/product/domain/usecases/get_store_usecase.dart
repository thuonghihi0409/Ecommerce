import 'package:thuongmaidientu/features/customer/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/customer/product/domain/repositories/product_repository.dart';

class GetStoreUsecase {
  final ProductRepository repository;

  GetStoreUsecase(this.repository);

  Future<Store?> call() {
    return repository.getStore();
  }
}
