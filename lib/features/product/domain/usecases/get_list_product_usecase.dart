import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetListProductUseCase {
  final ProductRepository repository;

  GetListProductUseCase(this.repository);

  Future<ListModel<Product>?> call() {
    return repository.getListProduct();
  }
}
