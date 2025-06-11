part of 'product_bloc.dart';

class ProductState extends Equatable {
  final ListModel<Product> listProduct;
  final ProductDetail? productDetailModel;
  final bool isGetDetail;
  final String getProductDetailError;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isRefreshing;

  const ProductState({
    required this.listProduct,
    this.productDetailModel,
    this.getProductDetailError = '',
    this.isGetDetail = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
  });

  factory ProductState.empty() {
    return const ProductState(
      listProduct: ListModel(),
      isGetDetail: false,
      getProductDetailError: "",
      productDetailModel: null,
      isLoading: false,
      isLoadingMore: false,
      isRefreshing: false,
    );
  }

  ProductState copyWith({
    ListModel<Product>? listProduct,
    ProductDetail? productDetailModel,
    bool? isGetDetail,
    String? getProductDetailError,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isRefreshing,
  }) {
    return ProductState(
      listProduct: listProduct ?? this.listProduct,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isGetDetail: isGetDetail ?? this.isGetDetail,
      productDetailModel: productDetailModel ?? this.productDetailModel,
      getProductDetailError:
          getProductDetailError ?? this.getProductDetailError,
    );
  }

  @override
  List<Object?> get props => [
        listProduct,
        isLoading,
        isLoadingMore,
        isRefreshing,
        isGetDetail,
        productDetailModel,
        getProductDetailError,
      ];
}
