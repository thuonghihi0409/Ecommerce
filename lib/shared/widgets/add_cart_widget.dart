import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/quantity_selector_widget.dart';

class AddCartWidget extends StatefulWidget {
  final ProductDetail? productDetail;
  final String lableButton;
  final Function(ProductItem) onTap;
  const AddCartWidget(
      {super.key,
      required this.productDetail,
      required this.lableButton,
      required this.onTap});

  @override
  State<AddCartWidget> createState() => _AddCartWidgetState();
}

class _AddCartWidgetState extends State<AddCartWidget> {
  int _selectedIndex = 0;
  late String _userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userId = context.read<ProfileBloc>().state.profile?.id ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCacheImageNetwork(
                  imageUrl:
                      widget.productDetail?.variants?[_selectedIndex].cover,
                  height: 120,
                  width: 120,
                  borderRadius: 5,
                ),
                20.w,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                NavigationService.instance.goBack();
                              },
                              icon: const Icon(Icons.cancel))
                        ],
                      ),
                      Text(
                        "${widget.productDetail?.variants?[_selectedIndex].price ?? 0} VND",
                        style:
                            AppTextStyles.textSize20(color: AppColor.primary),
                      ),
                      10.h,
                      Text(
                          "${"key_stock".tr()}:${widget.productDetail?.variants?[_selectedIndex].stock ?? 0}")
                    ],
                  ),
                )
              ],
            ),
            10.h,
            const Divider(),
            10.h,
            Text(
              "key_product".tr(),
              style: AppTextStyles.textSize16(),
            ),
            20.h,
            Wrap(
              spacing: 20,
              runSpacing: 20,
              direction: Axis.horizontal,
              children: (widget.productDetail?.variants ?? [])
                  .asMap()
                  .entries
                  .map((item) => InkWell(
                        onTap: () {
                          if (_selectedIndex == item.key) {
                            return;
                          }
                          setState(() {
                            _selectedIndex = item.key;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: item.key == _selectedIndex
                                  ? AppColor.greyColor.withAlpha(120)
                                  : Colors.transparent),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomCacheImageNetwork(
                                imageUrl: item.value.cover,
                                height: 40,
                                width: 30,
                              ),
                              5.w,
                              Text(
                                item.value.name ?? "",
                                style: AppTextStyles.textSize12(),
                              )
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
            20.h,
            const Divider(),
            20.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "key_quantity".tr(),
                  style: AppTextStyles.textSize12(),
                ),
                QuantitySelector(onChanged: (number) {})
              ],
            ),
            20.h,
          ],
        ),
        CustomButton(
          text: widget.lableButton,
          onPressed: () {
            widget.onTap;
            BlocProvider.of<CartBloc>(context).add(AddToCart(
                productId: widget.productDetail?.productId ?? "",
                variantId:
                    widget.productDetail?.variants?[_selectedIndex].id ?? "",
                id: _userId,
                storeId: context.read<ProductBloc>().state.store?.id ?? ""));
            NavigationService.instance.goBack();
          },
        ),
        10.h
      ],
    );
  }
}
