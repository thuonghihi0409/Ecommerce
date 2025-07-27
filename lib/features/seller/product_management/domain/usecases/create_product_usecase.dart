import 'package:thuongmaidientu/features/customer/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/seller/product_management/domain/repositories/product_management_repository.dart';

class CreateProductUsecase {
  final ProductManagementRepository productManagementRepository;

  CreateProductUsecase(this.productManagementRepository);
  Future<void> call(ProductDetail product) async {
    await productManagementRepository.createProductDetail(product);
  }
}
