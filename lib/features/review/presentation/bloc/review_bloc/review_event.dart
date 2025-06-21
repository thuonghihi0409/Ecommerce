part of 'review_bloc.dart';

class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

class GetListReview extends ReviewEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const GetListReview(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class GetListCategory extends ReviewEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const GetListCategory(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class GetReviewDetail extends ReviewEvent {
  final String ReviewId;
  const GetReviewDetail({required this.ReviewId});
}
