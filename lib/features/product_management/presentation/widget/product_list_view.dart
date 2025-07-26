import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:menuqueue/index.dart';
import 'package:menuqueue/models/products/category_model.dart';
import 'package:menuqueue/models/products/type_model.dart';
import 'package:menuqueue/screens/products/widgets/filter_buttom.dart';
import 'package:plugin_helper/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/products/products_bloc.dart';
import '../../../configs/app_text_styles.dart';
import '../../../models/products/products_model.dart';
import '../../../models/query_operation/filter_data_model.dart';
import '../../../models/query_operation/order_data_model.dart';
import '../../../widgets/app_list_view_custom.dart';
import '../../../widgets/button_custom.dart';
import '../../../widgets/text_field_custom.dart';
import 'header_list_product.dart';
import 'item_product.dart';

class ProductListView extends StatefulWidget {
  final Function(ProductsModel)? function;

  final StatusProduct statusProduct;
  const ProductListView({
    super.key,
    required this.statusProduct,
    this.function,
  });

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView>
    with AutomaticKeepAliveClientMixin {
  List<CategoryModel>? listCategories;
  List<TypeModel>? listTypes;
  List<FilterDataModel> listFilters = [];
  List<FilterDataModel> listFilterAndSearch = [];
  List<OrderDataModel> listOrders = [];

  FilterDataModel? search;
  List<ProductsModel> listProducts = [];
  TextEditingController searchController = TextEditingController();
  late final _productBloc = BlocProvider.of<ProductsBloc>(context);
  late final _authBloc = BlocProvider.of<AuthBloc>(context);

  List<SortStatus> isOrderByNameASC = [SortStatus.none];
  bool _isFilter = false;

  @override
  bool get wantKeepAlive => true;
  final supabase = Supabase.instance.client;
  late final realtimeChannelStatus;
  late final realtimeChannelSoldOut;
  late final realtimeChannelProduct;
  void resetFilters() {
    _productBloc.add(ResetFilter(status: widget.statusProduct));
    setState(() {
      _productBloc.state.isFilterCategoryPublished;
      listFilterAndSearch = [];
      listFilters = [];
      listOrders = [];
      search = null;
      searchController.clear();
      isOrderByNameASC[0] = SortStatus.none;
      _isFilter = false;
      _getData();
      _productBloc.add(GetCount());
    });
  }

  @override
  void initState() {
    listCategories = _productBloc.state.listCategories.results;
    listTypes = _productBloc.state.listTypes.results;
    String? businessId = _authBloc.state.profileModel?.businessId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      realtimeChannelSoldOut = supabase
          .channel(
              "product_sold_out_${_authBloc.state.profileModel?.businessId}")
          .onBroadcast(
              event: "UPDATE",
              callback: (payload) {
                _productBloc.add(OnUpdateSoldOut(
                    payload: payload,
                    eventName: "UPDATE",
                    businessId: businessId));
              })
          .subscribe(
        (status, error) {
          log('Subscribe status product sold out: $status');
          log('Subscribe error: $error');
        },
      );
      realtimeChannelStatus = supabase
          .channel("product_status_${_authBloc.state.profileModel?.businessId}")
          .onBroadcast(
              event: "UPDATE",
              callback: (payload) {
                log("on update status product");
                _productBloc.add(OnUpdateStatus(
                    payload: payload,
                    eventName: "UPDATE",
                    businessId: businessId));
              })
          .subscribe(
        (status, error) {
          log('Subscribe status product change status: $status');
          log('Subscribe error: $error');
        },
      );

      supabase
          .channel('public:products')
          .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'products',
            callback: (payload) {
              log('update product: ${payload.toString()}');
              _productBloc.add(RealtimeChannelProduct(
                  payload: payload, businessId: businessId));
            },
          )
          .subscribe(
        (status, error) {
          log('Subscribe table product status: $status');
          log('Subscribe error: $error');
        },
      );

      if (mounted) {
        setState(() {
          _getData();
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    supabase.removeAllChannels();

    searchController.dispose();
    super.dispose();
  }

  _getData({bool isFreshing = false, bool isLoadingMore = false}) async {
    _productBloc.add(GetProducts(
        isFreshing: isFreshing,
        isLoadingMore: isLoadingMore,
        statusProduct: widget.statusProduct,
        param: _getParameters(isFreshing, isLoadingMore),
        isFilter: _isFilter));
  }

  Map<String, dynamic> _getParameters(bool isFreshing, bool isLoadingMore) {
    listFilterAndSearch = List.from(listFilters);
    bool isAddLanguage = false;
    if (search != null) {
      listFilterAndSearch.add(search!);
      listFilterAndSearch.add(const FilterDataModel(
          field: "languageCode", type: FilterTypes.equals, value: "en"));
      isAddLanguage = true;
    }
    listFilterAndSearch.add(FilterDataModel(
        field: "status",
        type: FilterTypes.equals,
        value: widget.statusProduct.name));
    if (isOrderByNameASC[0] == SortStatus.asc) {
      listFilterAndSearch.add(const FilterDataModel(
          field: "orderByName",
          type: FilterTypes.equals,
          value: OrderType.asc));
      if (!isAddLanguage) {
        listFilterAndSearch.add(const FilterDataModel(
            field: "languageCode", type: FilterTypes.equals, value: "en"));
        isAddLanguage = true;
      }
    } else if (isOrderByNameASC[0] == SortStatus.desc) {
      listFilterAndSearch.add(const FilterDataModel(
          field: "orderByName",
          type: FilterTypes.equals,
          value: OrderType.desc));
      if (!isAddLanguage) {
        listFilterAndSearch.add(const FilterDataModel(
            field: "languageCode", type: FilterTypes.equals, value: "en"));
        isAddLanguage = true;
      }
    }
    log("params list filter ===== $listFilterAndSearch");
    return Helper.convertToPrismaFilter(
      limit: 10,
      offset: isLoadingMore ? listProducts.length : 0,
      filter: listFilterAndSearch,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
      if (widget.statusProduct == StatusProduct.published) {
        listProducts = state.listProductsPublisher.results ?? [];
      } else {
        listProducts = state.listProductsUnpublisher.results ?? [];
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          8.h,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: SearchTextField(
                  textEditingController: searchController,
                  onChange: (search) {
                    this.search = FilterDataModel(
                        field: "name",
                        type: FilterTypes.icontains,
                        value: search);

                    _getData();
                  },
                  hintText: "key_name".tr(),
                ),
              ),
              const Expanded(
                flex: 4,
                child: SizedBox(),
              ),
              Expanded(
                flex: 2,
                child: FilterButton(
                  onPressed: (filter) {
                    listFilters = filter ?? [];
                    _isFilter = filter?.isNotEmpty ?? false;
                    log("on is filter ${_isFilter.toString()}");
                    _getData();
                  },
                  onCancel: () {
                    _productBloc.add(ResetFilter(status: widget.statusProduct));
                    setState(() {
                      listFilters = [];
                      _isFilter = false;
                      _getData();
                      _productBloc.add(GetCount());
                    });
                  },
                  status: widget.statusProduct,
                ),
              ),
              20.w,
              Expanded(
                flex: 2,
                child: ButtonCustom(
                  height: 25,
                  title: "key_reset".tr(),
                  onPressed: () {
                    resetFilters();
                  },
                  padding: const EdgeInsets.all(6),
                  textStyle: AppTextStyles.textSize10(),
                ),
              )
            ],
          ),
          10.h,
          HeaderListProduct(
            orderByNameASC: isOrderByNameASC,
            onAction: (listSort) {
              isOrderByNameASC = List.from(listSort);
              _getData();
            },
          ),
          Expanded(
            child: AppListViewCustom(
              onRefresh: () {
                _getData(isFreshing: true);
              },
              onLoadMore: () {
                _getData(isLoadingMore: true);
              },
              data: widget.statusProduct == StatusProduct.published
                  ? state.listProductsPublisher
                  : state.listProductsUnpublisher,
              renderItem: (int index) {
                return ItemProducts(
                  item: listProducts[index],
                  index: index,
                  function: widget.function,
                  onAction: () {
                    _productBloc.add(const GetProducts(
                      isFreshing: true,
                      isLoadingMore: false,
                      statusProduct: StatusProduct.published,
                    ));

                    _productBloc.add(const GetProducts(
                      isFreshing: true,
                      isLoadingMore: false,
                      statusProduct: StatusProduct.unpublished,
                    ));
                  },
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
