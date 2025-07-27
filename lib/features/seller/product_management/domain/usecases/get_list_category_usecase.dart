import 'package:thuongmaidientu/features/customer/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/customer/product/domain/repositories/product_repository.dart';

class GetListCategoryUseCase {
  final ProductRepository repository;

  GetListCategoryUseCase(this.repository);

  Future<List<Category>?> call() {
    return repository.getListCategory();
  }
}
