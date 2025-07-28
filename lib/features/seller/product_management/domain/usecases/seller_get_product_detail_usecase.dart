import 'package:thuongmaidientu/features/customer/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/seller/product_management/domain/repositories/product_management_repository.dart';

class SellerGetProductDetailUsecase {
  final ProductManagementRepository repository;

  SellerGetProductDetailUsecase(this.repository);

  Future<ProductDetail?> call(String id) {
    return repository.getProductDetail(id);
  }
}
