import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/Cart/domain/usecases/get_list_Cart_usecase.dart';
import 'package:thuongmaidientu/features/cart/domain/entities/cart_item.dart';
import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:thuongmaidientu/features/cart/domain/usecases/delete_cart_usecase.dart';
import 'package:thuongmaidientu/features/cart/domain/usecases/get_count_cart_usecase.dart';
import 'package:thuongmaidientu/features/cart/domain/usecases/update_cart_usecase.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/store.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetListCartUseCase getListCartUseCase;
  final AddToCartUsecase addToCartUsecase;
  final UpdateCartUsecase updateCartUsecase;
  final DeleteCartUsecase deleteCartUsecase;
  final GetCountCartUsecase getCountCartUsecase;

  CartBloc(this.getListCartUseCase, this.addToCartUsecase,
      this.deleteCartUsecase, this.updateCartUsecase, this.getCountCartUsecase)
      : super(CartState.empty()) {
    on<GetListCart>(_getListCart);
    on<AddToCart>(_addToCart);
    on<UpdateCart>(_updateCart);
    on<DeleteCart>(_deleteCart);
    on<GetCountCart>(_getCountCart);
  }

  void _getListCart(GetListCart event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final listCart = await getListCartUseCase.call(event.id ?? "");

      emit(state.copyWith(isLoading: false, listCart: listCart));
      event.onSuccess?.call();
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listCart: state.listCart
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
      log(ParseError.fromJson(e).message);
    }
  }

  void _getCountCart(GetCountCart event, Emitter<CartState> emit) async {
    try {
      final countCart = await getCountCartUsecase.call(event.userId ?? "");

      emit(state.copyWith(totalProduct: countCart));
    } catch (e) {
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
      log(ParseError.fromJson(e).message);
    }
  }

  void _addToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await addToCartUsecase.call(event.userId, event.productId, event.storeId,
          event.variantId, event.quantity);
      emit(state.copyWith(
        isLoading: false,
      ));
      Helper.showToastBottom(
          message: "key_add_to_cart_success".tr(), type: ToastType.success);
      add(GetCountCart(userId: event.userId));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listCart: state.listCart
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _updateCart(UpdateCart event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await updateCartUsecase.call(event.userId ?? "", event.productItem);
      emit(state.copyWith(
        isLoading: false,
      ));
      add(GetListCart(id: event.userId));
      add(GetCountCart(userId: event.userId));

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

  void _deleteCart(DeleteCart event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await deleteCartUsecase.call(
          event.cartId, event.userId, event.productItemId);

      emit(state.copyWith(
        isLoading: false,
      ));
      add(GetListCart(id: event.userId));
      add(GetCountCart(userId: event.userId));
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
