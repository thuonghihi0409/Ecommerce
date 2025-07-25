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
  final List<OrderItem> orders;
  final bool isDeleteCart;
  final Function? onSuccess;

  const CreateOrder(
      {required this.userId,
      required this.orders,
      this.isDeleteCart = false,
      this.onSuccess});
}

class UpdateOrder extends OrderEvent {
  final String? userId;
  final ProductItem productItem;

  const UpdateOrder({
    this.userId,
    required this.productItem,
  });
}

class GetCountOrder extends OrderEvent {
  final String? userId;

  const GetCountOrder({
    required this.userId,
  });
}
