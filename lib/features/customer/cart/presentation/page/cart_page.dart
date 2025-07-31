import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_assets.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/features/customer/cart/domain/entities/cart_item.dart';
import 'package:thuongmaidientu/features/customer/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:thuongmaidientu/features/customer/cart/presentation/widget/cart_item_widget.dart';
import 'package:thuongmaidientu/features/customer/order/presentation/page/create_order_page.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/list_empty_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ScrollController _scrollController = ScrollController();
  late List<CartItem?> _listCarts;
  int _total = 0;

  @override
  void initState() {
    super.initState();
    _getDate();
  }

  _getDate() async {
    final id = context.read<ProfileBloc>().state.profile?.id;
    context.read<CartBloc>().add(GetListCart(
        id: id ?? "",
        onSuccess: () {
          _listCarts = List.generate(
              (context.read<CartBloc>().state.listCart.results ?? []).length,
              (_) => null);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: CustomAppBar(
          title: "key_cart".tr(),
          isShowCartIcon: false,
        ),
        body: Builder(builder: (context) {
          if (state.isLoading) {
            return const CustomLoading(
              isLoading: true,
            );
          }
          if ((state.listCart.results ?? []).isEmpty) {
            return Center(
                child: ListEmptyWidget(
                    title: "key_no_product_cart".tr(),
                    icon: AppAssets.cartIcon));
          }
          return Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 5),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => 5.h,
                    controller: _scrollController,
                    itemCount: state.listCart.results?.length ?? 0,
                    itemBuilder: (context, index) {
                      final product = state.listCart.results?[index];
                      return CartItemWidget(
                        cartItem: product!,
                        onChangeSelect: (item) {
                          setState(() {
                            _total = 0;

                            _listCarts[index] = item;

                            for (var item in _listCarts) {
                              if (item != null) {
                                for (var product in item.productItem) {
                                  _total += (product.variant?.price ?? 0);
                                }
                              }
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    if (_total != 0)
                      Text(
                          "${"key_sum".tr()}: ${Helper.formatCurrencyVND(_total)}"),
                    if (_total != 0) 10.w,
                    Expanded(
                        child: CustomButton(
                      isEnable: _total != 0,
                      text: "key_buy_now".tr(),
                      borderRadius: 0,
                      onPressed: () {
                        NavigationService.instance.push(
                          CreateOrderPage(
                            isDeleteCart: true,
                            cartItems: _listCarts
                                .where((item) => item != null)
                                .toList(),
                            total: _total,
                          ),
                        );
                      },
                    ))
                  ],
                )
              ],
            ),
          );
        }),
      );
    });
  }
}
