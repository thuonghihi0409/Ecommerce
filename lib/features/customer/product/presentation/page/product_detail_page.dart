import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/chat/presentation/bloc/profile_bloc/chat_bloc.dart';
import 'package:thuongmaidientu/features/chat/presentation/page/chat_detail_page.dart';
import 'package:thuongmaidientu/features/customer/cart/domain/entities/cart_item.dart';
import 'package:thuongmaidientu/features/customer/cart/domain/entities/product_item.dart';
import 'package:thuongmaidientu/features/customer/cart/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:thuongmaidientu/features/customer/order/presentation/page/create_order_page.dart';
import 'package:thuongmaidientu/features/customer/product/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:thuongmaidientu/features/customer/product/presentation/page/store_detail.dart';
import 'package:thuongmaidientu/features/customer/product/presentation/widget/product_card.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/features/review/presentation/page/review_page.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';
import 'package:thuongmaidientu/shared/widgets/add_to_cart_widget.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_carausel_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/overlay_custom.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;
  final String categoryId;
  const ProductDetailPage(
      {super.key, required this.productId, required this.categoryId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late String _userId;
  int _index = 0;
  @override
  void initState() {
    super.initState();
    _userId = context.read<ProfileBloc>().state.profile?.id ?? "";
    _getDate();
  }

  _getDate() async {
    context.read<ProductBloc>().add(GetProductDetail(
        userId: _userId,
        productId: widget.productId,
        categoryId: widget.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return OverlayLoadingCustom(
      loadingWidget:
          BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        return CustomLoading(
          isLoading: state.isGetDetail,
          isOverlay: true,
        );
      }),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          backgroundColor: Colors.transparent,
          title: "key_product_detail".tr(),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageCarousel(
                            imageUrls: state.productDetailModel?.images ?? []),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 80,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      (state.productDetailModel?.variants ?? [])
                                          .length,
                                  itemBuilder: (context, index) {
                                    final variant =
                                        (state.productDetailModel!.variants ??
                                            [])[index];
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          _index = index;
                                        });
                                      },
                                      child: CustomCacheImageNetwork(
                                        borderRadius: 5,
                                        imageUrl: variant.cover,
                                        height: 80,
                                        width: 70,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 10),
                                ),
                              ),
                              10.h,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      Helper.formatCurrencyVND(
                                          Helper.getDiscount(
                                              state
                                                      .productDetailModel
                                                      ?.variants?[_index]
                                                      .prices
                                                      ?.price ??
                                                  0,
                                              state.productDetailModel
                                                  ?.promotion)),
                                      style: AppTextStyles.textSize14(
                                          color: AppColor.primary)),
                                  IconButton(
                                      onPressed: () {
                                        context.read<ProductBloc>().add(
                                            UpdateWistlist(
                                                productId: state
                                                        .productDetailModel
                                                        ?.productId ??
                                                    "",
                                                userId: _userId,
                                                isLike: !(state
                                                        .productDetailModel
                                                        ?.isLike ??
                                                    false)));
                                      },
                                      icon: Icon(
                                          !(state.productDetailModel?.isLike ??
                                                  false)
                                              ? Icons.favorite_border_outlined
                                              : Icons.favorite,
                                          color: Colors.red)),
                                ],
                              ),
                              if (state.productDetailModel?.promotion != null)
                                Text(
                                    Helper.formatCurrencyVND(state
                                        .productDetailModel
                                        ?.variants?[_index]
                                        .prices
                                        ?.price),
                                    style: AppTextStyles.textSize10(
                                        color: AppColor.primary,
                                        decoration:
                                            TextDecoration.lineThrough)),
                              10.h,
                              Text(
                                state.productDetailModel?.productName ?? "",
                                style: AppTextStyles.textSize16(),
                              ),
                              5.h,
                              Text(
                                state.productDetailModel?.description ?? "",
                                style: AppTextStyles.textSize14(),
                              ),
                              5.h,
                              Text(
                                "${"key_solded".tr()} ${Helper.formatNumber(state.productDetailModel?.totalSold ?? 0)}",
                                style: AppTextStyles.textSize16(
                                    color: AppColor.greyColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              10.h
                            ],
                          ),
                        ),
                        Container(
                          height: 5,
                          color: AppColor.greyColor.withAlpha(50),
                        ),
                        10.h,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              NavigationService.instance.push(ReviewPage(
                                productDetail: state.productDetailModel,
                              ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      (state.productDetailModel?.avgRating ?? 0)
                                          .toString(),
                                      style: AppTextStyles.textSize18(),
                                    ),
                                    const Icon(
                                      Icons.star_half,
                                      color: AppColor.yellowColor,
                                      size: 28,
                                    ),
                                    Text(
                                      "${"key_review".tr()}(${Helper.formatNumber(state.productDetailModel?.totalRating ?? 0)})",
                                      style: AppTextStyles.textSize18(),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "key_view_all".tr(),
                                      style: AppTextStyles.textSize16(),
                                    ),
                                    5.w,
                                    const Icon(Icons.chevron_right)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        10.h,
                        Container(
                          height: 5,
                          color: AppColor.greyColor.withAlpha(50),
                        ),
                        10.h,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    child: CustomCacheImageNetwork(
                                      imageUrl: state
                                          .productDetailModel?.store?.logoUrl,
                                      height: 80,
                                      width: 80,
                                      boxFit: BoxFit.fill,
                                    ),
                                  ),
                                  10.w,
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.productDetailModel?.store
                                                  ?.name ??
                                              "",
                                          style: AppTextStyles.textSize20(),
                                        ),
                                        5.h,
                                        Text(
                                          state.productDetailModel?.store
                                                  ?.address ??
                                              "",
                                          style: AppTextStyles.textSize12(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  10.w,
                                  Expanded(
                                      flex: 1,
                                      child: CustomButton(
                                        borderColor: AppColor.primary,
                                        padding: const EdgeInsets.all(5),
                                        borderRadius: 2,
                                        height: 40,
                                        text: "key_view_store".tr(),
                                        textStyle: AppTextStyles.textSize10(),
                                        backgroundColor:
                                            AppColor.greyColor.withAlpha(150),
                                        onPressed: () {
                                          NavigationService.instance
                                              .push(StoreDetail(
                                            store:
                                                state.productDetailModel?.store,
                                          ));
                                        },
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        20.h,
                        Center(
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: (state.productSummerice ?? [])
                                .map((item) => SizedBox(
                                      width: context.widthScreen * 0.47,
                                      child: ProductCard(
                                          product: item,
                                          onTap: () {
                                            NavigationService.instance
                                                .replace(ProductDetailPage(
                                              productId: item.productId,
                                              categoryId: item.categoryId ?? "",
                                            ));
                                          }),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: "key_chat".tr(),
                        borderRadius: 0,
                        onPressed: () {
                          final user =
                              context.read<ProfileBloc>().state.profile;
                          context.read<ChatBloc>().add(CreateConversation(
                              user: user!,
                              store: state.productDetailModel!.store!,
                              onSuccess: (conversation, isNew) {
                                NavigationService.instance.push(ChatDetailPage(
                                  productId:
                                      state.productDetailModel?.productId,
                                ));
                              }));
                        },
                      ),
                    ),
                    2.w,
                    Expanded(
                        child: CustomButton(
                      text: "key_add_to_cart".tr(),
                      borderRadius: 0,
                      onPressed: () {
                        Helper.showCustomBottomSheet(
                          headerCustom: AddCartWidget(
                            productDetail: state.productDetailModel,
                            lableButton: 'key_add_to_cart'.tr(),
                            onTap: (productItem, index, quantity) {
                              final userId = context
                                      .read<ProfileBloc>()
                                      .state
                                      .profile
                                      ?.id ??
                                  "";
                              context.read<CartBloc>().add(AddToCart(
                                  userId: userId,
                                  productId: widget.productId,
                                  storeId:
                                      state.productDetailModel?.store?.id ?? "",
                                  variantId: state.productDetailModel
                                          ?.variants?[index].id ??
                                      "",
                                  quantity: quantity));
                            },
                          ),
                          context: context,
                        );
                      },
                    )),
                    2.w,
                    Expanded(
                        child: CustomButton(
                      text: "key_buy_now".tr(),
                      borderRadius: 0,
                      onPressed: () {
                        Helper.showCustomBottomSheet(
                          headerCustom: AddCartWidget(
                            productDetail: state.productDetailModel,
                            lableButton: "key_buy_now".tr(),
                            onTap: (productItem, index, quantity) {
                              try {
                                log("hihihii");
                                NavigationService.instance.push(CreateOrderPage(
                                  cartItems: [
                                    CartItem(
                                        store: state.productDetailModel!.store!,
                                        productItem: [
                                          ProductItem(
                                              id: "",
                                              productDetail:
                                                  state.productDetailModel!,
                                              variant: state.productDetailModel!
                                                  .variants![index],
                                              number: quantity)
                                        ],
                                        id: "")
                                  ],
                                  total: state.productDetailModel!
                                          .variants![index].prices!.price! *
                                      quantity,
                                  subtotal: Helper.getDiscount(
                                          state.productDetailModel!
                                              .variants![index].prices!.price!,
                                          state.productDetailModel?.promotion) *
                                      quantity,
                                ));
                              } catch (e) {
                                log(ParseError.fromJson(e).message);
                              }
                            },
                          ),
                          context: context,
                        );
                      },
                    )),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
