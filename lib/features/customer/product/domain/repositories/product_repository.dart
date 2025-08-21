import 'package:thuongmaidientu/features/customer/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/store.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../entities/product.dart';

abstract class ProductRepository {
  Future<ListModel<Product>> getListProduct({
    String? search,
    String? categoryId,
    int? minPrice,
    int? maxPrice,
    String? storeId,
  });
  Future<ProductDetail> getProductDetail(String id, String userId);
  Future<Store> getStore();
  Future<List<Product>> getListProductSummerice(String categoryId);
  Future<List<Category>> getListCategory();
  Future<void> updateWishlist(String id, String userId, bool isLike);
  Future<List<ProductDetail>> getWishlist(String userId);
}
