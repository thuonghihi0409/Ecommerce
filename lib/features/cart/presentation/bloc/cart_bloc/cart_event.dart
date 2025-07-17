part of 'cart_bloc.dart';

class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetListCart extends CartEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const GetListCart(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class AddToCart extends CartEvent {
  final String? id;
  final String productId;
  final String storeId;
  final String variantId;

  const AddToCart(
      {this.id,
      required this.productId,
      required this.storeId,
      required this.variantId});
}

class UpdateCart extends CartEvent {
  final String? id;
  final ProductItem productItem;

  const UpdateCart({
    this.id,
    required this.productItem,
  });
}

class DeleteCart extends CartEvent {
  final String? id;
  final ProductItem productItem;

  const DeleteCart({
    this.id,
    required this.productItem,
  });
}
