import 'package:thuongmaidientu/shared/service/supabase_client.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../models/review_model.dart';

abstract class ReviewRemoteDatasource {
  Future<ListModel<ReviewModel>> getListReview(String id);
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDatasource {
  ReviewRemoteDataSourceImpl();

  @override
  Future<ListModel<ReviewModel>> getListReview(String id) async {
    final data = await supabase.from("Reviews").select('''
    *,
    image_urls: Images(url),
    user: Users(*),
    variant: Variants(*)
    ''').eq("product_id", id);

    final result = ListModel(
        results: data.map((product) => ReviewModel.fromJson(product)).toList());

    return result;
  }
}
