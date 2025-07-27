import 'package:thuongmaidientu/features/customer/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/store.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../../domain/repositories/product_management_repository.dart';
import '../datasources/product_mamagement_remote_datasource.dart';

class ProductManagementRepositoryImpl implements ProductManagementRepository {
  final ProductManagementRemoteDatasource remoteDataSource;

  ProductManagementRepositoryImpl(this.remoteDataSource);

  @override
  Future<ListModel<Product>> getListProduct() async {
    final userModel = await remoteDataSource.getListProduct();
    return userModel;
  }

  @override
  Future<ProductDetail> getProductDetail(String id) async {
    final productdetail = await remoteDataSource.getProductDetail(id);
    return productdetail;
  }

  @override
  Future<Store> getStore() async {
    final store = await remoteDataSource.getStore();
    return store;
  }

  @override
  Future<List<Product>> getListProductSummerice(String categoryId) async {
    final productModels =
        await remoteDataSource.getListProductSummerice(categoryId);
    return productModels;
  }

  @override
  Future<List<Category>> getListCategory() async {
    final listCategory = await remoteDataSource.getListCategory();
    return listCategory;
  }

  @override
  Future<void> createProductDetail(ProductDetail product) async {
    await remoteDataSource.createProductDetail(product);
  }
}
