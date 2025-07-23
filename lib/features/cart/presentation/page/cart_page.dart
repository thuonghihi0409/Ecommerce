import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/features/cart/domain/entities/cart_item.dart';
import 'package:thuongmaidientu/features/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:thuongmaidientu/features/cart/presentation/widget/cart_item_widget.dart';
import 'package:thuongmaidientu/features/order/presentation/page/create_order_page.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';

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
        ),
        body: Builder(builder: (context) {
          if (state.isLoading) {
            return const CustomLoading(
              isLoading: true,
            );
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
                            log("haha${_listCarts.length}");
                            _listCarts[index] = item;
                            log(index.toString());
                            log(_listCarts[index].toString());
                            for (var item in _listCarts) {
                              log("hihi");
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
                    Text(
                        "${"key_sum".tr()}: ${Helper.formatCurrencyVND(_total)}"),
                    10.w,
                    Expanded(
                        child: CustomButton(
                      text: "key_buy_now".tr(),
                      borderRadius: 0,
                      onPressed: () {
                        NavigationService.instance.push(
                          CreateOrderPage(
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
