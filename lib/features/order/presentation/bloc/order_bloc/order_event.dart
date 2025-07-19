part of 'order_bloc.dart';

class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class GetListOrder extends OrderEvent {
  final String? id;
  final Function(OrderState)? onSuccess;
  final OrderStatus orderStatus;
  final bool isLoadingMore, isRefreshing;
  const GetListOrder(
      {this.id,
      this.orderStatus = OrderStatus.pending,
      this.isLoadingMore = false,
      this.isRefreshing = false,
      this.onSuccess});
}

class CreateOrder extends OrderEvent {
  final String userId;
  final String productId;
  final String storeId;
  final String variantId;
  final int quantity;

  const CreateOrder(
      {required this.userId,
      required this.productId,
      required this.storeId,
      required this.variantId,
      required this.quantity});
}

class UpdateOrder extends OrderEvent {
  final String? userId;
  final ProductItem productItem;

  const UpdateOrder({
    this.userId,
    required this.productItem,
  });
}
