import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/core/app_text_style.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product.dart';
import 'package:thuongmaidientu/features/product/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/widgets/appbar_custom.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_cache_custom.dart';
import 'package:thuongmaidientu/shared/widgets/image_carausel_custom.dart';
import 'package:thuongmaidientu/shared/widgets/laoding_custom.dart';
import 'package:thuongmaidientu/shared/widgets/overlay_custom.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    _getDate();
  }

  _getDate() async {
    context
        .read<ProductBloc>()
        .add(GetProductDetail(productId: widget.product.productId));
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
        appBar: CustomAppBar(
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.share_outlined)),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_shopping_cart_outlined)),
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.more_vert_outlined)),
          ],
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
                        SizedBox(
                          height: 80,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                state.productDetailModel?.variants.length ?? 0,
                            itemBuilder: (context, index) {
                              final variant =
                                  state.productDetailModel!.variants[index];
                              return CustomCacheImageNetwork(
                                imageUrl: variant.cover,
                                height: 80,
                                width: 50,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 8),
                          ),
                        ),
                        10.h,
                        Text(
                          "${state.productDetailModel?.price ?? 0} VND",
                          style:
                              AppTextStyles.textSize20(color: AppColor.primary),
                        ),
                        10.h,
                        Text(
                          state.productDetailModel?.productName ?? "",
                          style: AppTextStyles.textSize16(),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: "key_buy_now".tr(),
                        borderRadius: 0,
                      ),
                    ),
                    2.w,
                    Expanded(
                        child: CustomButton(
                      text: "key_buy_now".tr(),
                      borderRadius: 0,
                    )),
                    2.w,
                    Expanded(
                        child: CustomButton(
                      text: "key_buy_now".tr(),
                      borderRadius: 0,
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
