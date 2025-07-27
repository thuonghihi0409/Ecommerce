import 'package:thuongmaidientu/features/customer/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/store.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../entities/product.dart';

abstract class ProductRepository {
  Future<ListModel<Product>> getListProduct();
  Future<ProductDetail> getProductDetail(String id);
  Future<Store> getStore();
  Future<List<Product>> getListProductSummerice(String categoryId);
  Future<List<Category>> getListCategory();
}
