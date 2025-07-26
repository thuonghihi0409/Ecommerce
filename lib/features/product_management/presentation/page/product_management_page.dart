import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/features/product/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:thuongmaidientu/features/product/presentation/page/product_detail_page.dart';
import 'package:thuongmaidientu/features/product/presentation/widget/product_card.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';

class ProductManagementPage extends StatefulWidget {
  const ProductManagementPage({super.key});

  @override
  State<ProductManagementPage> createState() => _ProductManagementPageState();
}

class _ProductManagementPageState extends State<ProductManagementPage> {
  final ScrollController _scrollController = ScrollController();
  final int _selectCategory = -1;

  @override
  void initState() {
    super.initState();
    _getDate();
  }

  _getDate() async {
    context.read<ProductBloc>()
      ..add(const GetListProduct())
      ..add(const GetListCategory());
  }

  void _onRefresh() {}

  void _onLoading() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColor.greyColor.withAlpha(20),
        appBar: CustomAppBar(
          title: "key_product_management".tr(),
          showLeading: false,
          isShowCartIcon: false,
          isShowChatIcon: false,
          actions: const [Icon(Icons.add)],
        ),
        body: Builder(builder: (context) {
          if (state.isLoading) {
            return const CustomLoading(
              isLoading: true,
            );
          }
          return Column(
            children: [
              5.h,
              Expanded(
                child: GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: state.listProduct.results?.length ?? 0,
                  itemBuilder: (context, index) {
                    final product = state.listProduct.results?[index];
                    return ProductCard(
                        product: product!,
                        onTap: () {
                          NavigationService.instance
                              .push(ProductDetailPage(product: product));
                        });
                  },
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}
