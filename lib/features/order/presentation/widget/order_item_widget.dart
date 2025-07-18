import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/cart/domain/entities/cart_item.dart';
import 'package:thuongmaidientu/features/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/add_to_cart_widget.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/quantity_selector_widget.dart';

class OrderItemWidget extends StatefulWidget {
  final CartItem cartItem;
  const OrderItemWidget({super.key, required this.cartItem});

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool _isSelectAll = false;
  List<bool> _isSelect = [];
  late String _userId;
  @override
  void initState() {
    _isSelect = List.generate(widget.cartItem.productItem.length, (_) => false);
    _userId = context.read<ProfileBloc>().state.profile?.id ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: AppColor.greyColor.withAlpha(10),
                offset: const Offset(0, 4)),
          ],
          borderRadius: BorderRadius.circular(8),
          color: AppColor.greyColor.withAlpha(50)),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                  value: _isSelectAll,
                  onChanged: (val) {
                    setState(() {
                      _isSelectAll = val!;
                      for (int i = 0; i < _isSelect.length; i++) {
                        _isSelect[i] = _isSelectAll;
                      }
                    });
                  }),
              10.w,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cartItem.store.name ?? "",
                    style: AppTextStyles.textSize20(),
                  ),
                  5.h,
                  Text(
                    widget.cartItem.store.address ?? "",
                    style: AppTextStyles.textSize12(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          10.h,
          const Divider(),
          10.h,
          ...widget.cartItem.productItem.asMap().entries.map((entrie) =>
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Checkbox(
                        value:
                            _isSelectAll ? _isSelectAll : _isSelect[entrie.key],
                        onChanged: (val) {
                          setState(() {
                            _isSelect[entrie.key] = val!;

                            if (_isSelect
                                .any((selected) => selected == false)) {
                              _isSelectAll = false;
                            } else {
                              _isSelectAll = true;
                            }
                          });
                        }),
                    CustomCacheImageNetwork(
                      imageUrl: entrie.value.variant?.cover,
                      height: 80,
                      width: 80,
                      boxFit: BoxFit.fill,
                    ),
                    20.w,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entrie.value.productDetail?.productName ?? "",
                            style: AppTextStyles.textSize20(),
                          ),
                          10.h,
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: AppColor.greyColor.withAlpha(120),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    entrie.value.variant?.name ?? "",
                                    style: AppTextStyles.textSize12(),
                                  ),
                                  5.w,
                                  const Icon(Icons.expand_more)
                                ],
                              ),
                            ),
                            onTap: () {
                              Helper.showCustomBottomSheet(
                                headerCustom: Column(
                                  children: [
                                    AddCartWidget(
                                      productItem: entrie.value,
                                      productDetail: entrie.value.productDetail,
                                      lableButton: 'key_confirm',
                                      onTap: (productItem, index, quantity) {
                                        context.read<CartBloc>().add(UpdateCart(
                                            productItem: productItem,
                                            userId: _userId));
                                      },
                                    ),
                                  ],
                                ),
                                context: context,
                              );
                            },
                          ),
                          5.h,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                (entrie.value.variant?.price ?? 0).toString(),
                                style: AppTextStyles.textSize12(),
                                overflow: TextOverflow.ellipsis,
                              ),
                              QuantitySelector(
                                min: 0,
                                onChanged: (val) {
                                  if (val < 1) {
                                    context.read<CartBloc>().add(DeleteCart(
                                        cartId: widget.cartItem.id,
                                        userId: _userId,
                                        productItemId: entrie.value.id));
                                  }
                                  context.read<CartBloc>().add(UpdateCart(
                                      productItem:
                                          entrie.value.copyWith(number: val),
                                      userId: _userId));
                                },
                                initialValue: entrie.value.number,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
