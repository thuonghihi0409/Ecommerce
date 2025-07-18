import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/Cart/domain/usecases/get_list_Cart_usecase.dart';
import 'package:thuongmaidientu/features/cart/domain/entities/cart_item.dart';
import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:thuongmaidientu/features/cart/domain/usecases/delete_cart_usecase.dart';
import 'package:thuongmaidientu/features/cart/domain/usecases/update_cart_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetListCartUseCase getListCartUseCase;
  final AddToCartUsecase addToCartUsecase;
  final UpdateCartUsecase updateCartUsecase;
  final DeleteCartUsecase deleteCartUsecase;

  OrderBloc(this.getListCartUseCase, this.addToCartUsecase,
      this.deleteCartUsecase, this.updateCartUsecase)
      : super(OrderState.empty()) {
    on<GetListCart>(_getListCart);
    on<AddToCart>(_addToCart);
    on<UpdateCart>(_updateCart);
    on<DeleteCart>(_deleteCart);
  }

  void _getListCart(GetListCart event, Emitter<OrderState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final listCart = await getListCartUseCase.call(event.id ?? "");
      emit(state.copyWith(isLoading: false, listCart: listCart));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listCart: state.listCart
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
      log(ParseError.fromJson(e).message);
    }
  }

  void _addToCart(AddToCart event, Emitter<OrderState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await addToCartUsecase.call(event.userId, event.productId, event.storeId,
          event.variantId, event.quantity);
      emit(state.copyWith(
        isLoading: false,
      ));
      Helper.showToastBottom(
          message: "key_add_to_cart_success".tr(), type: ToastType.success);
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listCart: state.listCart
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _updateCart(UpdateCart event, Emitter<OrderState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await updateCartUsecase.call(event.userId ?? "", event.productItem);
      emit(state.copyWith(
        isLoading: false,
      ));
      add(GetListCart(id: event.userId));

      // Helper.showToastBottom(
      //     message: "key_update_cart_success".tr(), type: ToastType.success);
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listCart: state.listCart
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _deleteCart(DeleteCart event, Emitter<OrderState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await deleteCartUsecase.call(
          event.cartId, event.userId, event.productItemId);

      final newlist = state.listCart.results ?? [];
      newlist.removeWhere((item) => item.id == event.productItemId);
      emit(state.copyWith(
        isLoading: false,
        listCart: state.listCart.copyWith(results: newlist),
      ));
      //   add(GetListCart(id: event.userId));

      Helper.showToastBottom(
          message: "key_delete_cart_success".tr(), type: ToastType.success);
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listCart: state.listCart
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }
}
