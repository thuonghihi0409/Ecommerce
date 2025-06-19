import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../entities/product.dart';

abstract class ProductRepository {
  Future<ListModel<Product>> getListProduct();
  Future<ProductDetail> getProductDetail();
  Future<Store> getStore();
  Future<List<Product>> getListProductSummerice();
  Future<List<Category>> getListCategory();
}
