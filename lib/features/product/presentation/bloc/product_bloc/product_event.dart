part of 'product_bloc.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetListProduct extends ProductEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const GetListProduct(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class GetListCategory extends ProductEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const GetListCategory(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class GetProductDetail extends ProductEvent {
  final String productId;
  const GetProductDetail({required this.productId});
}
