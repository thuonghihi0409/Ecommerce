import 'package:thuongmaidientu/features/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/product/domain/repositories/product_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

class GetListProductUseCase {
  final ProductRepository repository;

  GetListProductUseCase(this.repository);

  Future<ListModel<Product>?> call() {
    return repository.getListProduct();
  }
}
