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

  const AddToCart({
    this.id,
  });
}
