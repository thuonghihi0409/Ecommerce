import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_list_category_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_list_product_summerice_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_list_product_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_product_detail_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_store_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetListProductUseCase _getListProductUseCase;
  final GetProductDetailUsecase _getProductDetailUsecase;
  final GetStoreUsecase _getStoreUsecase;
  final GetListProductSummericeUseCase _getListProductSummericeUseCase;
  final GetListCategoryUseCase _getListCategoryUseCase;
  ProductBloc(
      this._getListProductUseCase,
      this._getProductDetailUsecase,
      this._getStoreUsecase,
      this._getListProductSummericeUseCase,
      this._getListCategoryUseCase)
      : super(ProductState.empty()) {
    on<GetListProduct>(_getListProduct);
    on<GetListCategory>(_getListCategory);
    on<GetProductDetail>(_getProductDetail);
  }

  void _getListProduct(GetListProduct event, Emitter<ProductState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final listProduct = await _getListProductUseCase.call();
      emit(state.copyWith(isLoading: false, listProduct: listProduct));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listProduct: state.listProduct
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      log(e.toString());
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _getListCategory(
      GetListCategory event, Emitter<ProductState> emit) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final listCategory = await _getListCategoryUseCase.call();
      log("bloc ${(listCategory ?? []).length}");
      emit(state.copyWith(listCategory: listCategory));
      log("bloc 1 ${(state.listCategory ?? []).length}");
    } catch (e) {
      emit(state.copyWith(
          listProduct: state.listProduct
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _getProductDetail(
      GetProductDetail event, Emitter<ProductState> emit) async {
    try {
      emit(state.copyWith(isGetDetail: true));
      final product = await _getProductDetailUsecase.call();
      final store = await _getStoreUsecase.call();
      final listSummerice = await _getListProductSummericeUseCase.call();
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(
          isGetDetail: false,
          productDetailModel: product,
          getProductDetailError: "",
          store: store,
          listProductSummerice: listSummerice));
    } catch (e) {
      emit(state.copyWith(
          isGetDetail: false,
          getProductDetailError: ParseError.fromJson(e).message));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }
}
