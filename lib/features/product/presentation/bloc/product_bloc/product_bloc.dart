import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_list_product_usecase.dart';
import 'package:thuongmaidientu/features/product/domain/usecases/get_product_detail_usecase.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/list_model.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetListProductUseCase getListProductUseCase;
  final GetProductDetailUsecase getProductDetailUsecase;
  ProductBloc(this.getListProductUseCase, this.getProductDetailUsecase)
      : super(ProductState.empty()) {
    on<GetListProduct>(_getListProduct);
    on<GetListCategory>(_getListCategory);
    on<GetProductDetail>(_getProductDetail);
  }

  void _getListProduct(GetListProduct event, Emitter<ProductState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(seconds: 2));
      final listProduct = await getListProductUseCase.call();
      emit(state.copyWith(isLoading: false, listProduct: listProduct));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          listProduct: state.listProduct
              .copyWith(errorMessage: ParseError.fromJson(e).message)));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }

  void _getListCategory(
      GetListCategory event, Emitter<ProductState> emit) async {}
  void _getProductDetail(
      GetProductDetail event, Emitter<ProductState> emit) async {
    try {
      emit(state.copyWith(isGetDetail: true));
      final listProduct = await getProductDetailUsecase.call();
      emit(state.copyWith(
          isGetDetail: false,
          productDetailModel: listProduct,
          getProductDetailError: ""));
    } catch (e) {
      emit(state.copyWith(
          isGetDetail: false,
          getProductDetailError: ParseError.fromJson(e).message));
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
    }
  }
}
