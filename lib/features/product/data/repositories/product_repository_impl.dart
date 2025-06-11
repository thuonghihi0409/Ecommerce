import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<ListModel<Product>> getListProduct() async {
    final userModel = await remoteDataSource.getListProduct();
    return userModel;
  }

  @override
  Future<ProductDetail> getProductDetail() async {
    final productdetail = await remoteDataSource.getProductDetail();
    return productdetail;
  }
}
