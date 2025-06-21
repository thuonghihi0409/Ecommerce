import 'package:thuongmaidientu/features/review/domain/entities/review.dart';
import 'package:thuongmaidientu/features/review/domain/repositories/review_repository.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';

import '../datasources/review_remote_datasource.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDatasource remoteDataSource;

  ReviewRepositoryImpl(this.remoteDataSource);

  @override
  Future<ListModel<Review>> getListReview() async {
    final userModel = await remoteDataSource.getListReview();
    return userModel;
  }
}
