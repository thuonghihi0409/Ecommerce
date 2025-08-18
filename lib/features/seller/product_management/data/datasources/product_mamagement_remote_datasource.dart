import 'dart:developer';

import 'package:thuongmaidientu/features/customer/product/data/models/category_model.dart';
import 'package:thuongmaidientu/features/customer/product/data/models/product_detail_model.dart';
import 'package:thuongmaidientu/features/customer/product/data/models/promotion_model.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/promotion.dart';
import 'package:thuongmaidientu/features/seller/product_management/data/models/seller_product_model.dart';
import 'package:thuongmaidientu/features/seller/product_management/domain/entities/seller_product.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

abstract class ProductManagementRemoteDatasource {
  Future<ListModel<SellerProductModel>> getListProduct(String storeId);
  Future<ProductDetailModel> getProductDetail(String id);
  Future<void> createProductDetail(ProductDetail product);
  Future<List<Category>> getListCategory();
  Future<void> updateVariants(List<Variant> variants);
  Future<void> updateProduct(ProductDetail product);
  Future<void> createPromotion(
      Promotion promotion, List<SellerProduct> product);
  Future<List<PromotionModel>> getListPrmotion(String id);
  Future<void> updatePromotion(Promotion promotion);
}

class ProductManagementRemoteDataSourceImpl
    implements ProductManagementRemoteDatasource {
  ProductManagementRemoteDataSourceImpl();

  @override
  Future<ListModel<SellerProductModel>> getListProduct(String storeId) async {
    final data = await supabase
        .from("Products")
        .select('''
      *,
      variants :  Variants(
        *,
        prices:Prices!inner(*)
      ),
      category: Categories(*),
      promotion: ProductPromotion(promotion:Promotions(*)))
      ''')
        .eq("store_id", storeId)
        .eq("is_deleted", false)
        .order('created_at',
            ascending: false,
            referencedTable: 'variants.prices') // sắp xếp bảng con
        .limit(1, referencedTable: 'variants.prices');
    final result = ListModel(
        results: data
            .map((product) => SellerProductModel.fromJson(product))
            .toList());

    return result;
  }

  @override
  Future<ProductDetailModel> getProductDetail(String id) async {
    final data = await supabase
        .from("Products")
        .select('''
      *,
      images:Images(*),
      variants:Variants(
        *,
        prices:Prices!inner(*)
      ),
      store:Stores(*),
      promotion:ProductPromotion(promotion:Promotions(*))
    ''')
        .eq("id", id)
        .order('created_at',
            ascending: false,
            referencedTable: 'variants.prices') // sắp xếp bảng con
        .limit(1,
            referencedTable:
                'variants.prices') // giới hạn 1 bản ghi cho bảng con
        .single();

    log(data.toString());
    return ProductDetailModel.fromJson(data);
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
    // if (product.variants != null && product.variants!.isNotEmpty) {
    //   final variantData = product.variants!.map((v) {
    //     return {
    //       'product_id': productId,
    //       'name': v.name,
    //       'price': v.price,
    //       'stock': v.stock,
    //       'cover': v.cover,
    //     };
    //   }).toList();

    //   await supabase.from('Variants').insert(variantData);
    // }

    // 1. Insert variants
    final insertedVariants = await supabase
        .from('Variants')
        .insert(product.variants!.map((v) {
          return {
            'product_id': productId,
            'name': v.name,
            'stock': v.stock,
            'cover': v.cover,
          };
        }).toList())
        .select('id'); // Lấy ID

// 2. Insert prices
    final now = DateTime.now().toIso8601String();
    final priceData = insertedVariants.asMap().entries.map((entry) {
      final index = entry.key;
      final variantId = entry.value['id'];
      final originalVariant = product.variants![index];

      return {
        'variant_id': variantId,
        'price': originalVariant.prices?.price ?? 0,
        'created_at': now,
      };
    }).toList();

    await supabase.from('Prices').insert(priceData);
  }

  @override
  Future<void> updateProduct(ProductDetail product) async {}

  @override
  Future<void> updateVariants(List<Variant> variants) async {
    for (final variant in variants) {
      await supabase.from('Variants').update({
        'stock': variant.stock,
      }).eq('id', variant.id);
    }
  }

  @override
  Future<void> createPromotion(
      Promotion promotion, List<SellerProduct> products) async {
    final result = await supabase
        .from("Promotions")
        .insert({
          "store_id": promotion.storeId,
          "end_time": (promotion.endTime ?? DateTime.now()).toIso8601String(),
          "start_time":
              (promotion.startTime ?? DateTime.now()).toIso8601String(),
          "type": "per",
          "amount": promotion.amount,
          "name": promotion.name,
        })
        .select()
        .single();

    final promotionId = result["id"];

    final productPromotionList = products.map((item) {
      return {
        "promotion_id": promotionId,
        "product_id": item.productId,
      };
    }).toList();

    // 3. Insert vào bảng trung gian ProductPromotion
    await supabase.from("ProductPromotion").insert(productPromotionList);
  }

  @override
  Future<List<PromotionModel>> getListPrmotion(String id) async {
    final result =
        await supabase.from("Promotions").select('''*''').eq("store_id", id);
    return result.map((e) => PromotionModel.fromJson(e)).toList();
  }

  @override
  Future<void> updatePromotion(Promotion promotion) async {}
}
