import 'package:thuongmaidientu/features/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/product/domain/repositories/product_repository.dart';

class GetListProductSummericeUseCase {
  final ProductRepository repository;

  GetListProductSummericeUseCase(this.repository);

  Future<List<Product>?> call(String categoryId) {
    return repository.getListProductSummerice(categoryId);
  }
}
