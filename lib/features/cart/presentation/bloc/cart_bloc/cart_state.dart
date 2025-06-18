part of 'cart_bloc.dart';

class CartState extends Equatable {
  final ListModel<CartItem> listCart;

  final bool isGetDetail;

  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;
  const CartState({
    required this.listCart,
    this.isGetDetail = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
  });

  factory CartState.empty() {
    return const CartState(
      listCart: ListModel(),
      isGetDetail: false,
      isLoading: false,
      isLoadingMore: false,
      isRefreshing: false,
    );
  }

  CartState copyWith(
      {ListModel<CartItem>? listCart,
      bool? isGetDetail,
      String? getCartDetailError,
      bool? isLoading,
      bool? isLoadingMore,
      bool? isRefreshing,
      Store? store}) {
    return CartState(
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
