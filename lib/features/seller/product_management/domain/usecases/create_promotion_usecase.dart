import 'package:thuongmaidientu/features/customer/product/domain/entities/promotion.dart';
import 'package:thuongmaidientu/features/seller/product_management/domain/entities/seller_product.dart';
import 'package:thuongmaidientu/features/seller/product_management/domain/repositories/product_management_repository.dart';

class CreatePromotionUsecase {
  final ProductManagementRepository repository;

  CreatePromotionUsecase(this.repository);
  Future<void> call(Promotion promotion, List<SellerProduct> product) {
    return repository.createPromotion(promotion, product);
  }
}
