import 'package:thuongmaidientu/features/customer/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/customer/product/domain/repositories/product_repository.dart';

class GetListProductSummericeUseCase {
  final ProductRepository repository;

  GetListProductSummericeUseCase(this.repository);

  Future<List<Product>?> call(String categoryId) {
    return repository.getListProductSummerice(categoryId);
  }
}
