import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/seller/product_management/presentation/bloc/product_management_bloc/product_management_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';

class ProductManagementPage extends StatefulWidget {
  const ProductManagementPage({super.key});

  @override
  State<ProductManagementPage> createState() => _ProductManagementPageState();
}

class _ProductManagementPageState extends State<ProductManagementPage> {
  final ScrollController _scrollController = ScrollController();
  final int _selectCategory = -1;
  late ProductDataSource _dataSource;
  List<Product> _products = [];

  String _searchQuery = '';
  @override
  void initState() {
    super.initState();
    _getDate();
  }

  _getDate() async {
    context.read<ProductManagementBloc>()
      ..add(const GetListProduct())
      ..add(const GetListCategory());
  }

  void _filterSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      final filtered = _products
          .where(
              (p) => (p.productName ?? "").toLowerCase().contains(_searchQuery))
          .toList();
      _dataSource.updateData(filtered);
    });
  }

  void _onRefresh() {}

  void _onLoading() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductManagementBloc, ProductManagementState>(
      builder: (context, state) {
        _products = state.listProduct.results ?? [];
        _dataSource = ProductDataSource(_products);

        return Scaffold(
          backgroundColor: AppColor.greyColor.withAlpha(20),
          appBar: CustomAppBar(
            title: "key_product_management".tr(),
            showLeading: false,
            isShowCartIcon: false,
            isShowChatIcon: false,
          ),
          body: state.isLoading
              ? const CustomLoading(isLoading: true)
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Tìm kiếm sản phẩm...',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: _filterSearch,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: PaginatedDataTable(
                          header: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Bảng sản phẩm',
                                style: AppTextStyles.textSize20(),
                              ),
                              SizedBox(
                                width: context.widthScreen * 0.5,
                              ),
                              Expanded(
                                child: CustomButton(
                                  text: "Thêm sản phẩm",
                                  onPressed: () {
                                    NavigationService.instance
                                        .pushNamed("create_product");
                                  },
                                ),
                              )
                            ],
                          ),
                          rowsPerPage: 10,
                          sortColumnIndex: _dataSource.sortColumnIndex,
                          sortAscending: _dataSource.sortAscending,
                          columns: [
                            const DataColumn(
                              label: Text('STT'),
                            ),
                            DataColumn(
                              label: const Text('Tên sản phẩm'),
                              onSort: (i, asc) => _dataSource.sort<String>(
                                getField: (p) => p.productName ?? "",
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            DataColumn(
                              label: const Text('Giá (VNĐ)'),
                              numeric: true,
                              onSort: (i, asc) => _dataSource.sort<int>(
                                getField: (p) => p.price ?? 0,
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            DataColumn(
                              label: const Text('Tồn kho'),
                              numeric: true,
                              onSort: (i, asc) => _dataSource.sort<int>(
                                getField: (p) => p.price ?? 0,
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            DataColumn(
                              label: const Text('Đã bán'),
                              numeric: true,
                              onSort: (i, asc) => _dataSource.sort<int>(
                                getField: (p) => p.price ?? 0,
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            DataColumn(
                              label: const Text('Đánh giá'),
                              numeric: true,
                              onSort: (i, asc) => _dataSource.sort<int>(
                                getField: (p) => p.price ?? 0,
                                ascending: asc,
                                columnIndex: i,
                                refresh: () => setState(() {}),
                              ),
                            ),
                            const DataColumn(
                              label: Text('Thao tác'),
                            ),
                          ],
                          source: _dataSource,
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class ProductDataSource extends DataTableSource {
  List<Product> _products;
  int? sortColumnIndex;
  bool sortAscending = true;

  ProductDataSource(this._products);

  void updateData(List<Product> newData) {
    _products = newData;
    notifyListeners();
  }

  void sort<T extends Comparable<dynamic>>({
    required T Function(Product p) getField,
    required bool ascending,
    required int columnIndex,
    required VoidCallback refresh,
  }) {
    _products.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    sortColumnIndex = columnIndex;
    sortAscending = ascending;
    refresh();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _products.length) return null;
    final product = _products[index];

    return DataRow(cells: [
      DataCell(Text('${index + 1}', style: AppTextStyles.textSize16())),
      DataCell(Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomCacheImageNetwork(
            imageUrl: product.cover,
            height: 40,
            width: 40,
            borderRadius: 20,
          ),
          20.w,
          Text(
            product.productName ?? "",
            style: AppTextStyles.textSize16(),
          ),
        ],
      )),
      DataCell(Text(Helper.formatCurrencyVND(product.price ?? 0),
          style: AppTextStyles.textSize16())),
      DataCell(
          Text('${product.price ?? 0}', style: AppTextStyles.textSize16())),
      DataCell(
          Text('${product.totalSold ?? 0}', style: AppTextStyles.textSize16())),
      DataCell(
          Text('${product.price ?? 0.0}', style: AppTextStyles.textSize16())),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.visibility),
            tooltip: "Chi tiết",
            onPressed: () {
              // TODO: Handle view
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: "Xoá",
            onPressed: () {
              // TODO: Handle delete
            },
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _products.length;

  @override
  int get selectedRowCount => 0;
}
