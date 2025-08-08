import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/promotion.dart';
import 'package:thuongmaidientu/features/seller/product_management/domain/entities/seller_product.dart';
import 'package:thuongmaidientu/features/seller/product_management/domain/usecases/create_promotion_usecase.dart';
import 'package:thuongmaidientu/features/seller/product_management/domain/usecases/get_list_promotion_usecase.dart';
import 'package:thuongmaidientu/features/seller/product_management/domain/usecases/update_promotion_uaecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'promotion_event.dart';
part 'promotion_state.dart';

class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  final GetListPromotionUsecase _getListPromotionUseCase;

  final CreatePromotionUsecase _createPromotionUsecase;

  final UpdatePromotionUsecase _updatePromotionUsecase;

  PromotionBloc(
    this._getListPromotionUseCase,
    this._createPromotionUsecase,
    this._updatePromotionUsecase,
  ) : super(PromotionState.empty()) {
    on<SellerGetListPromotion>(_getListPromotion);

    on<SellerCreatePromotion>(_createPromotion);
    on<SellerUpdatePromotion>(_updatePromotion);
  }

  void _getListPromotion(
      SellerGetListPromotion event, Emitter<PromotionState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final listPromotion = await _getListPromotionUseCase.call(event.id);
      log(listPromotion.length.toString());
      event.onSuccess?.call();
      emit(state.copyWith(isLoading: false, listPromotion: listPromotion));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
      ));
      log(e.toString());
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _createPromotion(
      SellerCreatePromotion event, Emitter<PromotionState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _createPromotionUsecase.call(event.promotion, event.products);
      event.onSuccess?.call();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
      event.onError?.call();
      log(ParseError.fromJson(e).message);
    }
  }

  void _updatePromotion(
      SellerUpdatePromotion event, Emitter<PromotionState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _updatePromotionUsecase.call(event.promotion, event.products);
      event.onSuccess?.call();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);

      log(ParseError.fromJson(e).message);
    }
  }
}
