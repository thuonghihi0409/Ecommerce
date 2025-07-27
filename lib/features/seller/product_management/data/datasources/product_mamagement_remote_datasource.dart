import 'package:thuongmaidientu/features/customer/product/data/models/category_model.dart';
import 'package:thuongmaidientu/features/customer/product/data/models/product_detail_model.dart';
import 'package:thuongmaidientu/features/customer/product/data/models/product_model.dart';
import 'package:thuongmaidientu/features/customer/product/data/models/store_model.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/store.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class ProductManagementRemoteDatasource {
  Future<ListModel<ProductModel>> getListProduct();
  Future<ProductDetailModel> getProductDetail(String id);
  Future<void> createProductDetail(ProductDetail product);
  Future<Store> getStore();
  Future<List<ProductModel>> getListProductSummerice(String categoryId);
  Future<List<Category>> getListCategory();
}

class ProductManagementRemoteDataSourceImpl
    implements ProductManagementRemoteDatasource {
  ProductManagementRemoteDataSourceImpl();

  @override
  Future<ListModel<ProductModel>> getListProduct() async {
    final data =
        await supabase.from("Products").select('''*,store : Stores(*)''');

    final result = ListModel(
        results:
            data.map((product) => ProductModel.fromJson(product)).toList());

    return result;
  }

  @override
  Future<ProductDetailModel> getProductDetail(String id) async {
    final data = await supabase.from("Products").select('''
      *,
      images : Images(*),
      variants : Variants(*),
      store : Stores(*)
      ''').eq("id", id).single();

    return ProductDetailModel.fromJson(data);
  }

  @override
  Future<Store> getStore() async {
    final data = await supabase.from("Stores").select('''*''').single();

    return StoreModel.fromJson(data);
  }

  @override
  Future<List<ProductModel>> getListProductSummerice(String categoryId) async {
    final data = await supabase
        .from("Products")
        .select('''*,store : Stores(*)''').eq("category_id", categoryId);

    return data.map((product) => ProductModel.fromJson(product)).toList();
  }

  @override
  Future<List<CategoryModel>> getListCategory() async {
    final data = await supabase.from("Categories").select('''*''');

    return data.map((item) => CategoryModel.fromJson(item)).toList();
  }

  @override
  Future<void> createProductDetail(ProductDetail product) async {
    // 1. Insert vào bảng products
    final insertedProduct = await supabase
        .from('Products')
        .insert({
          'cover': product.cover,
          'product_name': product.productName,
          'description': product.description,
          'price': product.price,
          'category_id': product.categoryId,
          'store_id': product.store?.id,
          'avg_rating': product.avgRating,
          'total_sold': product.totalSold,
          'total_rating': product.totalRating,
        })
        .select()
        .single();

    final productId = insertedProduct['id'];

    // 2. Insert ảnh vào bảng product_images
    if (product.images != null && product.images!.isNotEmpty) {
      final imageData = product.images!.map((img) {
        return {
          'product_id': productId,
          'url': img.url,
          'alt': img.alt,
        };
      }).toList();

      await supabase.from('Images').insert(imageData);
    }

    // 3. Insert biến thể vào bảng product_variants
    if (product.variants != null && product.variants!.isNotEmpty) {
      final variantData = product.variants!.map((v) {
        return {
          'product_id': productId,
          'name': v.name,
          'price': v.price,
          'stock': v.stock,
          'cover': v.cover,
        };
      }).toList();

      await supabase.from('Variants').insert(variantData);
    }
  }
}
