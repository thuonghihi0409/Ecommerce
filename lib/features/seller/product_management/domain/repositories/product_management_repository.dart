import 'package:thuongmaidientu/features/customer/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/store.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class ProductManagementRepository {
  Future<ListModel<Product>> getListProduct();
  Future<ProductDetail> getProductDetail(String id);
  Future<Store> getStore();
  Future<List<Product>> getListProductSummerice(String categoryId);
  Future<List<Category>> getListCategory();
  Future<void> createProductDetail(ProductDetail product);
}
