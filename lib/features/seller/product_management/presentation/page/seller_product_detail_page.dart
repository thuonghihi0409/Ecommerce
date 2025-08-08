import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/features/seller/product_management/presentation/bloc/product_management_bloc/product_management_bloc.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_carausel_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/overlay_custom.dart';

class SellerProductDetailPage extends StatefulWidget {
  final String id;
  const SellerProductDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<SellerProductDetailPage> createState() =>
      _SellerProductDetailPageState();
}

class _SellerProductDetailPageState extends State<SellerProductDetailPage> {
  late String _userId;
  final int _index = 0;
  @override
  void initState() {
    super.initState();
    _userId = context.read<ProfileBloc>().state.profile?.id ?? "";
    _getDate();
  }

  _getDate() async {
    context.read<ProductManagementBloc>().add(SellerGetProductDetail(
          productId: widget.id,
          onSuccess: () {},
        ));
  }

  @override
  Widget build(BuildContext context) {
    return OverlayLoadingCustom(
      loadingWidget: BlocBuilder<ProductManagementBloc, ProductManagementState>(
          builder: (context, state) {
        return CustomLoading(
          isLoading: state.isGetDetail,
          isOverlay: true,
        );
      }),
      child: Scaffold(
        appBar: CustomAppBar(
          backgroundColor: Colors.transparent,
          title: "key_product_detail".tr(),
        ),
        body: BlocBuilder<ProductManagementBloc, ProductManagementState>(
            builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ImageCarousel(
                                imageUrls:
                                    state.productDetailModel?.images ?? [],
                              ),
                            ),
                            40.w,
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.h,
                                Text(
                                  state.productDetailModel?.productName ?? "",
                                  style: AppTextStyles.textSize20(),
                                ),
                                5.h,
                                Text(
                                  state.productDetailModel?.description ?? "",
                                  style: AppTextStyles.textSize14(),
                                ),
                                5.h,
                                Text(
                                    Helper.formatCurrencyVND(((state
                                                .productDetailModel
                                                ?.variants?[_index]
                                                .price ??
                                            0) -
                                        (state.productDetailModel?.promotion
                                                    ?.amount ??
                                                0) *
                                            (state.productDetailModel
                                                    ?.variants?[_index].price ??
                                                0) *
                                            0.01)),
                                    style: AppTextStyles.textSize20(
                                        color: AppColor.primary)),
                                if (state.productDetailModel?.promotion != null)
                                  Text(
                                      Helper.formatCurrencyVND(state
                                          .productDetailModel
                                          ?.variants?[_index]
                                          .price),
                                      style: AppTextStyles.textSize16(
                                          color: AppColor.primary,
                                          decoration:
                                              TextDecoration.lineThrough)),
                                20.h,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: InkWell(
                                    onTap: () {
                                      NavigationService.instance
                                          .pushNamed("review", arguments: {
                                        "id":
                                            state.productDetailModel?.productId
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              (state.productDetailModel
                                                          ?.avgRating ??
                                                      0)
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
                                50.h,
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        text: "key_delete".tr(),
                                        onPressed: () {},
                                        isMinWidth: true,
                                      ),
                                    ),
                                    10.w,
                                    Expanded(
                                      child: CustomButton(
                                        text: "key_edit".tr(),
                                        onPressed: () {
                                          NavigationService.instance.pushNamed(
                                              "update_product",
                                              arguments: {
                                                "id": state.productDetailModel
                                                    ?.productId
                                              });
                                        },
                                        isMinWidth: true,
                                      ),
                                    ),
                                    10.w,
                                    Expanded(
                                      child: CustomButton(
                                        text: "key_block".tr(),
                                        onPressed: () {},
                                        isMinWidth: true,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ))
                          ],
                        ),
                        50.h,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "key_variants".tr(),
                                style: AppTextStyles.textSize16(),
                              ),
                              20.h,
                              ...(state.productDetailModel?.variants ?? [])
                                  .map((variant) => Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            CustomCacheImageNetwork(
                                              imageUrl: variant.cover,
                                              height: 150,
                                              width: 150,
                                            ),
                                            30.w,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  variant.name ?? "",
                                                  style: AppTextStyles
                                                      .textSize18(),
                                                ),
                                                10.h,
                                                Text(
                                                    Helper.formatCurrencyVND(((state
                                                                .productDetailModel
                                                                ?.variants?[
                                                                    _index]
                                                                .price ??
                                                            0) -
                                                        (state
                                                                    .productDetailModel
                                                                    ?.promotion
                                                                    ?.amount ??
                                                                0) *
                                                            (state
                                                                    .productDetailModel
                                                                    ?.variants?[
                                                                        _index]
                                                                    .price ??
                                                                0) *
                                                            0.01)),
                                                    style: AppTextStyles
                                                        .textSize18(
                                                            color: AppColor
                                                                .primary)),
                                                if (state.productDetailModel
                                                        ?.promotion !=
                                                    null)
                                                  Text(
                                                      Helper.formatCurrencyVND(
                                                          state
                                                              .productDetailModel
                                                              ?.variants?[
                                                                  _index]
                                                              .price),
                                                      style: AppTextStyles
                                                          .textSize16(
                                                              color: AppColor
                                                                  .primary,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough)),
                                                10.h,
                                                Text(
                                                  "${"key_in_stock".tr()}: ${variant.stock}",
                                                  style: AppTextStyles
                                                      .textSize18(),
                                                ),
                                                10.h,
                                                Text(
                                                  "${"key_solded".tr()}: ${variant.totalSold}",
                                                  style: AppTextStyles
                                                      .textSize16(),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                              10.h,
                            ],
                          ),
                        ),
                        Container(
                          height: 5,
                          color: AppColor.greyColor.withAlpha(50),
                        ),
                        10.h,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
