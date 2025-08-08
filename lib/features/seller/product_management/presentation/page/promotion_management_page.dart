import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/customer/product/domain/entities/promotion.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/features/seller/product_management/presentation/bloc/promotion_bloc/promotion_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/overlay_custom.dart';

class PromotionManagementPage extends StatefulWidget {
  const PromotionManagementPage({super.key});

  @override
  State<PromotionManagementPage> createState() =>
      _PromotionManagementPageState();
}

class _PromotionManagementPageState extends State<PromotionManagementPage> {
  List<Promotion> _promotions = []; // Giả sử đang lấy từ API/BLoC
  PromotionDataSource? _dataSource;
  String _searchQuery = "";
  late PromotionBloc _bloc;
  late String storeId;

  @override
  void initState() {
    super.initState();
    storeId = context.read<ProfileBloc>().state.store?.id ?? "";
    _bloc = context.read<PromotionBloc>();

    _bloc.add(SellerGetListPromotion(
        id: storeId,
        onSuccess: () {
          log("hihihi");
        }));
  }

  void _filterSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      final filtered = _promotions
          .where((p) => (p.name ?? "").toLowerCase().contains(_searchQuery))
          .toList();
      _dataSource!.updateData(filtered);
    });
  }

  @override
  Widget build(BuildContext context) {
    return OverlayLoadingCustom(
      loadingWidget:
          BlocBuilder<PromotionBloc, PromotionState>(builder: (context, state) {
        return CustomLoading(
          isOverlay: true,
          isLoading: state.isLoading,
        );
      }),
      child: BlocBuilder<PromotionBloc, PromotionState>(
        builder: (context, state) {
          _dataSource = PromotionDataSource(_bloc.state.listPromotion ?? []);
          _promotions = _bloc.state.listPromotion ?? [];
          if (state.isLoading && _dataSource == null) {
            return const SizedBox();
          }
          return Scaffold(
            backgroundColor: AppColor.greyColor.withAlpha(20),
            appBar: CustomAppBar(
              title: "key_promotion".tr(),
              showLeading: false,
              isShowCartIcon: false,
              isShowChatIcon: false,
            ),
            body: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'key_find_promotion'.tr(),
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: _filterSearch,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: PaginatedDataTable(
                      columnSpacing: 35,
                      header: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'key_table_promotion'.tr(),
                            style: AppTextStyles.textSize20(),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: context.widthScreen * 0.2,
                            child: CustomButton(
                              text: "key_add_promotion".tr(),
                              onPressed: () {
                                NavigationService.instance
                                    .pushNamed("create_promotion");
                              },
                            ),
                          ),
                        ],
                      ),
                      rowsPerPage: 5,
                      sortColumnIndex: _dataSource!.sortColumnIndex,
                      sortAscending: _dataSource!.sortAscending,
                      columns: [
                        DataColumn(
                            label:
                                Text("STT", style: AppTextStyles.textSize16())),
                        DataColumn(
                            label: Text("Tên CTKM",
                                style: AppTextStyles.textSize16())),
                        DataColumn(
                            label: Text("Loại",
                                style: AppTextStyles.textSize16())),
                        DataColumn(
                            label: Text("Giá trị",
                                style: AppTextStyles.textSize16())),
                        DataColumn(
                            label: Text("Bắt đầu",
                                style: AppTextStyles.textSize16())),
                        DataColumn(
                            label: Text("Kết thúc",
                                style: AppTextStyles.textSize16())),
                        DataColumn(
                            label: Text("Hành động",
                                style: AppTextStyles.textSize16())),
                      ],
                      source: _dataSource!,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PromotionDataSource extends DataTableSource {
  List<Promotion> _promotions;
  int? sortColumnIndex;
  bool sortAscending = true;

  PromotionDataSource(this._promotions);

  void updateData(List<Promotion> newData) {
    _promotions = newData;
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _promotions.length) return null;
    final promotion = _promotions[index];
    return DataRow(cells: [
      DataCell(Text('${index + 1}')),
      DataCell(Text(promotion.name ?? "")),
      DataCell(Text(promotion.type ?? "")),
      DataCell(Text(promotion.type == "percentage"
          ? "${promotion.amount?.toStringAsFixed(1)}%"
          : Helper.formatCurrencyVND(promotion.amount ?? 0))),
      DataCell(Text(DateFormat('dd/MM/yyyy').format(promotion.startTime!))),
      DataCell(Text(DateFormat('dd/MM/yyyy').format(promotion.endTime!))),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: "Chỉnh sửa",
            onPressed: () {
              NavigationService.instance.pushNamed("update_promotion",
                  arguments: {"id": promotion.id});
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: "Xóa",
            onPressed: () {
              // TODO: show confirm dialog & call BLoC/delete service
            },
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _promotions.length;

  @override
  int get selectedRowCount => 0;
}
