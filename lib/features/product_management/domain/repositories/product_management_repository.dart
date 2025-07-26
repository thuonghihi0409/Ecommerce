import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class ProductManagementRepository {
  Future<ListModel<Product>> getListProduct();
  Future<ProductDetail> getProductDetail(String id);
  Future<Store> getStore();
  Future<List<Product>> getListProductSummerice(String categoryId);
  Future<List<Category>> getListCategory();
}
