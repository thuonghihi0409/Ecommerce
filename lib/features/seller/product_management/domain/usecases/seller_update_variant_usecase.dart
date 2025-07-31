import 'package:thuongmaidientu/features/customer/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/seller/product_management/domain/repositories/product_management_repository.dart';

class SellerUpdateVariantUseCase {
  final ProductManagementRepository repository;

  SellerUpdateVariantUseCase(this.repository);

  Future<void> call(List<Variant> variants) {
    return repository.updateVariants(variants);
  }
}
