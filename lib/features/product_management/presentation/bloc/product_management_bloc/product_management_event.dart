part of 'product_management_bloc.dart';

class ProductManagementEvent extends Equatable {
  const ProductManagementEvent();

  @override
  List<Object> get props => [];
}

class GetListProduct extends ProductManagementEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const GetListProduct(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class GetListCategory extends ProductManagementEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const GetListCategory(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class GetProductDetail extends ProductManagementEvent {
  final String productId;
  final String categoryId;
  const GetProductDetail({required this.productId, required this.categoryId});
}
