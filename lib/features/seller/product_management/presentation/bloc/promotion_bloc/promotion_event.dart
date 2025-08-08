part of 'promotion_bloc.dart';

class PromotionEvent extends Equatable {
  const PromotionEvent();

  @override
  List<Object> get props => [];
}

class SellerGetListPromotion extends PromotionEvent {
  final String id;
  final Function? onSuccess;
  final bool isLoadingMore, isRefreshing;
  const SellerGetListPromotion(
      {required this.id,
      this.onSuccess,
      this.isLoadingMore = false,
      this.isRefreshing = false});
}

class SellerCreatePromotion extends PromotionEvent {
  final List<SellerProduct> products;
  final Promotion promotion;
  final Function? onSuccess;
  final Function? onError;
  const SellerCreatePromotion(
      {required this.promotion,
      required this.products,
      this.onSuccess,
      this.onError});
}

class SellerUpdatePromotion extends PromotionEvent {
  final List<SellerProduct> products;
  final Promotion promotion;
  final Function? onSuccess;
  const SellerUpdatePromotion(
      {required this.products, required this.promotion, this.onSuccess});
}
