part of 'order_bloc.dart';

class OrderState extends Equatable {
  final ListModel<CartItem> listCart;

  final bool isGetDetail;

  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;
  const OrderState({
    required this.listCart,
    this.isGetDetail = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
  });

  factory OrderState.empty() {
    return const OrderState(
      listCart: ListModel(),
      isGetDetail: false,
      isLoading: false,
      isLoadingMore: false,
      isRefreshing: false,
    );
  }

  OrderState copyWith(
      {ListModel<CartItem>? listCart,
      bool? isGetDetail,
      String? getCartDetailError,
      bool? isLoading,
      bool? isLoadingMore,
      bool? isRefreshing,
      Store? store}) {
    return OrderState(
      listCart: listCart ?? this.listCart,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isGetDetail: isGetDetail ?? this.isGetDetail,
    );
  }

  @override
  List<Object?> get props => [
        listCart,
        isLoading,
        isLoadingMore,
        isRefreshing,
        isGetDetail,
      ];
}
