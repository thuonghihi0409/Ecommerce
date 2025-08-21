import 'package:thuongmaidientu/features/customer/product/domain/entities/promotion.dart';
import 'package:thuongmaidientu/features/seller/product_management/domain/entities/seller_product.dart';
import 'package:thuongmaidientu/features/seller/product_management/domain/repositories/product_management_repository.dart';

class UpdatePromotionUsecase {
  final ProductManagementRepository repository;

  UpdatePromotionUsecase(this.repository);
  Future<void> call(Promotion promotion, List<SellerProduct> product) {
    return repository.updatePromotion(promotion);
  }
}
