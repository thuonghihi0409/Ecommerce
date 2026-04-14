import 'package:thuongmaidientu/features/review/domain/entities/review.dart';
import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../models/review_model.dart';

abstract class ReviewRemoteDatasource {
  Future<ListModel<ReviewModel>> getListReview(String id);
  Future<void> createReview(Review review, String id);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDatasource {
  ReviewRemoteDataSourceImpl();

  @override
  Future<ListModel<ReviewModel>> getListReview(String id) async {
    final data = await supabase.from("Reviews").select('''
    *,
    image_urls: Images(url),
    user: Users(*),
    variant: Variants(
        *,
        prices:Prices!inner(*)
      )
    ''').eq("product_id", id);

    final result = ListModel(
        results: data.map((product) => ReviewModel.fromJson(product)).toList());

    return result;
  }

  @override
  Future<void> createReview(Review review, String id) async {
    final response = await supabase
        .from("Reviews")
        .insert({
          "product_id": review.productId,
          "user_id": review.user?.id,
          "rating": review.rating,
          "content": review.content,
          "likes_count": review.likesCount,
          "variant_id": review.variant?.id
        })
        .select()
        .single();
    for (var image in review.imageUrls ?? []) {
      await supabase.from("Images").insert({
        "url": image,
        "review_id": response["id"],
      });
    }
    await supabase
        .from('ProductOrders')
        .update({"is_reviewed": true}).eq("id", id);

    final productId = review.productId;
    if (productId != null && productId.isNotEmpty) {
      final reviews = await supabase
          .from("Reviews")
          .select("rating")
          .eq("product_id", productId);
      final totalRating = reviews.length;
      final avgRating = totalRating == 0
          ? 0.0
          : reviews.fold<double>(
                0.0,
                (sum, item) =>
                    sum + ((item["rating"] as num?)?.toDouble() ?? 0.0),
              ) /
              totalRating;

      await supabase.from("Products").update({
        "avg_rating": avgRating,
        "total_rating": totalRating,
      }).eq("id", productId);
    }
  }
}
