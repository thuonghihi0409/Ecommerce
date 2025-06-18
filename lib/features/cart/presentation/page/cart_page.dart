import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/features/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:thuongmaidientu/features/cart/presentation/widget/cart_item_widget.dart';
import 'package:thuongmaidientu/features/product/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.grey.withAlpha(100),
        appBar: CustomAppBar(
          title: "key_cart".tr(),
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
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(8),
                  itemCount: state.listCart.results?.length ?? 0,
                  itemBuilder: (context, index) {
                    final product = state.listCart.results?[index];
                    return CartItemWidget(
                      cartItem: product!,
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
