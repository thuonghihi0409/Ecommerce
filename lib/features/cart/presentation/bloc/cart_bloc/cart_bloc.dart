import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/Cart/domain/usecases/get_list_Cart_usecase.dart';
import 'package:thuongmaidientu/features/cart/domain/entities/cart_item.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetListCartUseCase _getListCartUseCase;

  CartBloc(
    this._getListCartUseCase,
  ) : super(CartState.empty()) {
    on<GetListCart>(_getListCart);
    on<AddToCart>(_addToCart);
  }

  void _getListCart(GetListCart event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(seconds: 2));
      final listCart = await _getListCartUseCase.call();
      emit(state.copyWith(isLoading: false, listCart: listCart));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listCart: state.listCart
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _addToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(seconds: 2));

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
}
