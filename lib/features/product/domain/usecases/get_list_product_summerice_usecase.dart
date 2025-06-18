import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetListProductSummericeUseCase {
  final ProductRepository repository;

  GetListProductSummericeUseCase(this.repository);

  Future<List<Product>?> call() {
    return repository.getListProductSummerice();
  }
}
