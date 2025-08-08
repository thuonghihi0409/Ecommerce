part of 'promotion_bloc.dart';

class PromotionState extends Equatable {
  final List<Promotion>? listPromotion;
  final ProductDetail? productDetailModel;

  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;

  const PromotionState({
    this.productDetailModel,
    this.listPromotion,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
  });

  factory PromotionState.empty() {
    return const PromotionState(
        productDetailModel: null,
        isLoading: false,
        isLoadingMore: false,
        isRefreshing: false,
        listPromotion: null);
  }

  PromotionState copyWith(
      {bool? isLoading,
      bool? isLoadingMore,
      bool? isRefreshing,
      List<Promotion>? listPromotion}) {
    return PromotionState(
        isLoading: isLoading ?? this.isLoading,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        isRefreshing: isRefreshing ?? this.isRefreshing,
        productDetailModel: productDetailModel ?? productDetailModel,
        listPromotion: listPromotion ?? this.listPromotion);
  }

  @override
  List<Object?> get props => [
        isLoading,
        isLoadingMore,
        isRefreshing,
        productDetailModel,
      ];
}
