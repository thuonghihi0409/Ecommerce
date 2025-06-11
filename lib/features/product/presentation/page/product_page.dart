import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/features/product/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:thuongmaidientu/features/product/presentation/widget/product_card.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getDate();
  }

  _getDate() async {
    context.read<ProductBloc>().add(const GetListProduct());
  }

  void _onRefresh() {}

  void _onLoading() {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.grey.withAlpha(100),
        appBar: CustomAppBar(
          title: "key_technology_product".tr(),
          showLeading: false,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_shopping_cart_outlined))
          ],
        ),
        body: Builder(builder: (context) {
          if (state.isLoading) {
            return const CustomLoading(
              isLoading: true,
            );
          }
          return Column(
            children: [
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
                      onTap: () {},
                    );
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
