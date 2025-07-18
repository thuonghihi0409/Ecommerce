part of 'order_bloc.dart';

class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class GetListCart extends OrderEvent {
  final String? id;
  final bool isLoadingMore, isRefreshing;
  const GetListCart(
      {this.id, this.isLoadingMore = false, this.isRefreshing = false});
}

class AddToCart extends OrderEvent {
  final String userId;
  final String productId;
  final String storeId;
  final String variantId;
  final int quantity;

  const AddToCart(
      {required this.userId,
      required this.productId,
      required this.storeId,
      required this.variantId,
      required this.quantity});
}

class UpdateCart extends OrderEvent {
  final String? userId;
  final ProductItem productItem;

  const UpdateCart({
    this.userId,
    required this.productItem,
  });
}

class DeleteCart extends OrderEvent {
  final String userId;
  final String cartId;
  final String productItemId;

  const DeleteCart({
    required this.cartId,
    required this.userId,
    required this.productItemId,
  });
}
