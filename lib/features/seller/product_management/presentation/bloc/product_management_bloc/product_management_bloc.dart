import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/store.dart';
import 'package:thuongmaidientu/features/customer/product/domain/usecases/get_list_category_usecase.dart';
import 'package:thuongmaidientu/features/customer/product/domain/usecases/get_list_product_summerice_usecase.dart';
import 'package:thuongmaidientu/features/customer/product/domain/usecases/get_list_product_usecase.dart';
import 'package:thuongmaidientu/features/customer/product/domain/usecases/get_product_detail_usecase.dart';
import 'package:thuongmaidientu/features/seller/product_management/domain/usecases/create_product_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'product_management_event.dart';
part 'product_management_state.dart';

class ProductManagementBloc
    extends Bloc<ProductManagementEvent, ProductManagementState> {
  final GetListProductUseCase _getListProductUseCase;
  final GetProductDetailUsecase _getProductDetailUsecase;

  final CreateProductUsecase _createProductUsecase;
  final GetListProductSummericeUseCase _getListProductSummericeUseCase;
  final GetListCategoryUseCase _getListCategoryUseCase;
  ProductManagementBloc(
      this._getListProductUseCase,
      this._getProductDetailUsecase,
      this._getListProductSummericeUseCase,
      this._getListCategoryUseCase,
      this._createProductUsecase)
      : super(ProductManagementState.empty()) {
    on<GetListProduct>(_getListProduct);
    on<GetListCategory>(_getListCategory);
    on<GetProductDetail>(_getProductDetail);
    on<CreateProduct>(_createProduct);
  }

  void _getListProduct(
      GetListProduct event, Emitter<ProductManagementState> emit) async {
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
      GetListCategory event, Emitter<ProductManagementState> emit) async {
    try {
      final listCategory = await _getListCategoryUseCase.call();

      emit(state.copyWith(listCategory: listCategory));
    } catch (e) {
      emit(state.copyWith(
          listProduct: state.listProduct
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _getProductDetail(
      GetProductDetail event, Emitter<ProductManagementState> emit) async {
    try {
      emit(state.copyWith(isGetDetail: true));
      final product = await _getProductDetailUsecase.call(event.productId);

      final listSummerice =
          await _getListProductSummericeUseCase.call(event.categoryId);

      emit(state.copyWith(
          isGetDetail: false,
          productDetailModel: product,
          getProductDetailError: "",
          listProductSummerice: listSummerice));
    } catch (e) {
      emit(state.copyWith(
          isGetDetail: false,
          getProductDetailError: ParseError.fromJson(e).message));
      log(ParseError.fromJson(e).message);
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _createProduct(
      CreateProduct event, Emitter<ProductManagementState> emit) async {
    try {
      await _createProductUsecase.call(event.productDetail);
      event.onSuccess?.call();
    } catch (e) {
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
      event.onError?.call();
      log(ParseError.fromJson(e).message);
    }
  }
}
