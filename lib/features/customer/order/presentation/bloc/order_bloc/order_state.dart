part of 'order_bloc.dart';

class OrderState extends Equatable {
  final ListModel<OrderItem> listOrderPending; // Chờ duyệt
  final ListModel<OrderItem> listOrderWaiting; // Chuẩn bị hàng
  final ListModel<OrderItem> listOrderDelivering; // Đang giao
  final ListModel<OrderItem> listOrderDelivered; // Đã giao
  final ListModel<OrderItem> listOrderCancelled; // Đã hủy
  final ListModel<OrderItem> listOrderReviewed; // Đánh giá
  final ListModel<OrderItem> listOrderReturnRequested; // Yêu cầu trả hàng
  final ListModel<OrderItem> listOrderReturned; // Đã trả hàng

  final int count;
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
    required this.listOrderReturnRequested,
    required this.listOrderReturned,
    this.isGetDetail = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.count = 0,
  });

  factory OrderState.empty() {
    return const OrderState(
      listOrderPending: ListModel(),
      listOrderWaiting: ListModel(),
      listOrderDelivering: ListModel(),
      listOrderDelivered: ListModel(),
      listOrderCancelled: ListModel(),
      listOrderReviewed: ListModel(),
      listOrderReturnRequested: ListModel(),
      listOrderReturned: ListModel(),
      isGetDetail: false,
      isLoading: false,
      isLoadingMore: false,
      isRefreshing: false,
      count: 0,
    );
  }

  OrderState copyWith({
    ListModel<OrderItem>? listOrderPending,
    ListModel<OrderItem>? listOrderWaiting,
    ListModel<OrderItem>? listOrderDelivering,
    ListModel<OrderItem>? listOrderDelivered,
    ListModel<OrderItem>? listOrderCancelled,
    ListModel<OrderItem>? listOrderReviewed,
    ListModel<OrderItem>? listOrderReturnRequested,
    ListModel<OrderItem>? listOrderReturned,
    bool? isGetDetail,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isRefreshing,
    int? count,
  }) {
    return OrderState(
      listOrderPending: listOrderPending ?? this.listOrderPending,
      listOrderWaiting: listOrderWaiting ?? this.listOrderWaiting,
      listOrderDelivering: listOrderDelivering ?? this.listOrderDelivering,
      listOrderDelivered: listOrderDelivered ?? this.listOrderDelivered,
      listOrderCancelled: listOrderCancelled ?? this.listOrderCancelled,
      listOrderReviewed: listOrderReviewed ?? this.listOrderReviewed,
      listOrderReturnRequested:
          listOrderReturnRequested ?? this.listOrderReturnRequested,
      listOrderReturned: listOrderReturned ?? this.listOrderReturned,
      isGetDetail: isGetDetail ?? this.isGetDetail,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      count: count ?? this.count,
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
        listOrderReturnRequested,
        listOrderReturned,
        isGetDetail,
        isLoading,
        isLoadingMore,
        isRefreshing,
        count,
      ];
}
