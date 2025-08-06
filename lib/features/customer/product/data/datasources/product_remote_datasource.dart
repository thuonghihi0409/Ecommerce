import 'package:thuongmaidientu/features/customer/product/data/models/category_model.dart';
import 'package:thuongmaidientu/features/customer/product/data/models/product_detail_model.dart';
import 'package:thuongmaidientu/features/customer/product/data/models/store_model.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/store.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../models/product_model.dart';

abstract class ProductRemoteDatasource {
  Future<ListModel<ProductModel>> getListProduct({
    String? search,
    String? categoryId,
    int? minPrice,
    int? maxPrice,
    String? storeId,
  });
  Future<ProductDetailModel> getProductDetail(String id, String userId);
  Future<Store> getStore();
  Future<List<ProductModel>> getListProductSummerice(String categoryId);
  Future<List<Category>> getListCategory();
  Future<void> updateWishlist(String id, String userId, bool isLike);
  Future<List<ProductDetailModel>> getWishlist(String userId);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDatasource {
  ProductRemoteDataSourceImpl();

  @override
  Future<ListModel<ProductModel>> getListProduct({
    String? search,
    String? categoryId,
    int? minPrice,
    int? maxPrice,
    String? storeId,
  }) async {
    var query = supabase.from("Products").select('''*, store: Stores(*),
         promotion: ProductPromotion(promotion:Promotions(*))''');

    if (search != null && search.isNotEmpty) {
      query = query.ilike('product_name', '%$search%');
    }

    if (categoryId != null) {
      query = query.eq('category_id', categoryId);
    }

    if (storeId != null) {
      query = query.eq('store_id', storeId);
    }

    if (minPrice != null) {
      query = query.gte('price', minPrice);
    }

    if (maxPrice != null) {
      query = query.lte('price', maxPrice);
    }

    final data = await query;

    final result = ListModel(
      results: data.map((e) => ProductModel.fromJson(e)).toList(),
    );

    return result;
  }

  @override
  Future<ProductDetailModel> getProductDetail(String id, String userId) async {
    final data = await supabase.from("Products").select('''
      *,
      images : Images(*),
      variants : Variants(*),
      store : Stores(*),
       promotion: ProductPromotion(promotion:Promotions(*))
      ''').eq("id", id).single();
    final isLike = await supabase
        .from("Wishlist")
        .select('''*''')
        .eq("user_id", userId)
        .eq("product_id", id)
        .maybeSingle();
    data.addAll({"is_like": isLike == null ? false : true});
    return ProductDetailModel.fromJson(data);
  }

  @override
  Future<void> updateWishlist(String id, String userId, bool isLike) async {
    if (isLike) {
      await supabase
          .from("Wishlist")
          .insert({"user_id": userId, "product_id": id});
    } else {
      await supabase
          .from("Wishlist")
          .delete()
          .eq("user_id", userId)
          .eq("product_id", id);
    }
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
        .select('''*,store : Stores(*), promotion: ProductPromotion(promotion:Promotions(*))''').eq(
            "category_id", categoryId);

    return data.map((product) => ProductModel.fromJson(product)).toList();
  }

  @override
  Future<List<CategoryModel>> getListCategory() async {
    final data = await supabase.from("Categories").select('''*''');

    return data.map((item) => CategoryModel.fromJson(item)).toList();
  }

  @override
  Future<List<ProductDetailModel>> getWishlist(String userId) async {
    final data = await supabase
        .from("Wishlist")
        .select('''*, product : Products(*, images : Images(*),
      variants : Variants(*), store: Stores(*),  promotion: ProductPromotion(promotion:Promotions(*)))''').eq("user_id", userId);
    return data.map((item) {
      item["product"].addAll({"is_like": true});
      return ProductDetailModel.fromJson(item["product"]);
    }).toList();
  }
}
