import 'package:thuongmaidientu/features/customer/product/domain/entities/promotion.dart';
import 'package:thuongmaidientu/features/seller/product_management/domain/repositories/product_management_repository.dart';

class GetListPromotionUsecase {
  final ProductManagementRepository repository;

  GetListPromotionUsecase(this.repository);
  Future<List<Promotion>> call(String id) {
    return repository.getListPrmotion(id);
  }
}
