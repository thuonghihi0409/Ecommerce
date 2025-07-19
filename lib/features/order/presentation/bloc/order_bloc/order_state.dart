part of 'order_bloc.dart';

class OrderState extends Equatable {
  final ListModel<OrderItem> listOrderPending; // Chờ duyệt
  final ListModel<OrderItem> listOrderWaiting; // Chuẩn bị hàng
  final ListModel<OrderItem> listOrderDelivering; // Đang giao
  final ListModel<OrderItem> listOrderDelivered; // Đã giao
  final ListModel<OrderItem> listOrderCancelled; // Đã hủy
  final ListModel<OrderItem> listOrderReviewed; // Đánh giá

  final bool isGetDetail;
  final bool isLoading; // loading when create order
  final bool isLoadingMore;
  final bool isRefreshing;

  const OrderState({
    required this.listOrderPending,
    required this.listOrderWaiting,
    required this.listOrderDelivering,
    required this.listOrderDelivered,
    required this.listOrderCancelled,
    required this.listOrderReviewed,
    this.isGetDetail = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
  });

  factory OrderState.empty() {
    return const OrderState(
      listOrderPending: ListModel(),
      listOrderWaiting: ListModel(),
      listOrderDelivering: ListModel(),
      listOrderDelivered: ListModel(),
      listOrderCancelled: ListModel(),
      listOrderReviewed: ListModel(),
      isGetDetail: false,
      isLoading: false,
      isLoadingMore: false,
      isRefreshing: false,
    );
  }

  OrderState copyWith({
    ListModel<OrderItem>? listOrderPending,
    ListModel<OrderItem>? listOrderWaiting,
    ListModel<OrderItem>? listOrderDelivering,
    ListModel<OrderItem>? listOrderDelivered,
    ListModel<OrderItem>? listOrderCancelled,
    ListModel<OrderItem>? listOrderReviewed,
    bool? isGetDetail,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isRefreshing,
  }) {
    return OrderState(
      listOrderPending: listOrderPending ?? this.listOrderPending,
      listOrderWaiting: listOrderWaiting ?? this.listOrderWaiting,
      listOrderDelivering: listOrderDelivering ?? this.listOrderDelivering,
      listOrderDelivered: listOrderDelivered ?? this.listOrderDelivered,
      listOrderCancelled: listOrderCancelled ?? this.listOrderCancelled,
      listOrderReviewed: listOrderReviewed ?? this.listOrderReviewed,
      isGetDetail: isGetDetail ?? this.isGetDetail,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
        listOrderPending,
        listOrderWaiting,
        listOrderDelivering,
        listOrderDelivered,
        listOrderCancelled,
        listOrderReviewed,
        isGetDetail,
        isLoading,
        isLoadingMore,
        isRefreshing,
      ];
}
